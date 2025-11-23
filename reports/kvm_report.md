⚙️ KVM Workstation Architecture – Design Report
🎯 Obiettivo del Progetto

Creare una workstation di sviluppo industriale basata su Fedora Linux, capace di eseguire più macchine virtuali Windows 11 in parallelo, ognuna dedicata a un ambiente tecnico specifico:

Rockwell Automation (Studio5000, FactoryTalk, FT Optix)

Omron Sysmac Studio

Schneider Machine Expert

VM Office / Gestionali

Il tutto mantenendo:

performance elevate

latenza minima verso i PLC

stabilità dell’host

isolamento tra i vari ambienti Windows

produttività massima per sviluppatori e tecnici

🧠 Perché KVM (e non VMware/VirtualBox)

KVM è:

nativamente integrato nel kernel Linux

più veloce grazie alla virtualizzazione hardware diretta

progettato per carichi pesanti e multi-VM

stabile in contesti enterprise e industriali

flessibile per GPU, pass-through, reti industriali

Non richiede moduli esterni proprietari → meno crash, meno problemi.

🎮 Perché sfruttiamo GPU Intel per le VM

La tua macchina (Precision 7550 con i9-10885H) ha:

GPU Intel integrata (iGPU)

NVIDIA T1000 dedicata

💡 Il punto chiave:

La GPU Intel supportava nativamente GVT-g (virtualizzazione GPU) → suddividere la GPU in più istanze virtuali (vGPU).

Nel 2024–2025 il modulo GVT-g è stato deprecato e rimosso dal kernel.
Risultato: non possiamo più creare vGPU.

👉 Non è una limitazione della tua macchina, ma del kernel moderno.

🔄 Soluzione attuale migliore

Usare virtio-gpu + VirGL/VirTIO-Vulkan, che:

fornisce accelerazione hardware 3D alla VM

non richiede pass-through della GPU

è stabile

permette l’uso simultaneo di più VM

lascia la NVIDIA T1000 interamente all’host

Questo è lo schema:

Componente	Funzione
NVIDIA T1000	GPU principale di Fedora (desktop, effettistica, videoscaling)
Intel iGPU	Non isolata, ma utilizzabile per carichi leggeri/QEMU GL
virtio-gpu	Backend grafico delle VM (accelerato)
VirGL/Vulkan	Motore 3D usato dal guest Windows

👉 Le VM ottengono 3D sufficiente per: Sysmac, Studio5000, FactoryTalk Optix, Machine Expert.

🖥️ Perché NON usiamo Nvidia per le VM

La T1000:

non supporta vGPU

pass-through distacca la GPU dall’host

eliminerebbe completamente l’ambiente Linux grafico

è complicato da far funzionare con Windows + Secure Boot + driver Nvidia guest

Per te è critico mantenere l’host operativo → niente pass-through.

🏗️ Architettura Virtuale Complessiva
✨ Obiettivo: più VM Windows 11 contemporanee
VM	Uso	RAM	CPU	Note
VM Office	Outlook, Teams, Browser	12 GB	4 CPU	Template base
VM Rockwell	Studio5000, FT View, FT Optix	16–20 GB	6 CPU	carico più pesante
VM Omron	Sysmac Studio	10–12 GB	4 CPU	richiede 3D
VM Schneider	Machine Expert	12 GB	4 CPU	medio-alta complessità
🧩 Perché questa struttura funziona
1. Isolamento perfetto dei software industriali

Ogni vendor richiede librerie specifiche, versioni di .NET, driver USB/IP, pacchetti OPC/DA/UA, protocolli.

→ Tenendoli in VM separate eviti conflitti disastrosi.

2. Ottimizzazione delle prestazioni

Le VM più pesanti (Rockwell) ricevono core dedicati (CPU pinning).

La RAM è gestita tramite HugePages → meno overhead.

Il disco è RAW o QCOW2 ottimizzato Virtio-SCSI.

3. Rete industriale reale (bridge)

Permette comunicazione reale con PLC:

EtherNet/IP

Modbus

OPC-UA

Profinet (limitatamente)

Multicast industriale

4. Stabilità dell’host

L’host Fedora resta snello e affidabile, isolato da crash, update Windows, driver rotti, malfunzionamenti Rockwell.

⚙️ Tecnologia usata

KVM/QEMU

libvirt + virt-manager

virtio-gpu + VirGL

bridge networking

OVMF UEFI + TPM 2.0 (swtpm) → richiesto da Windows 11

virtio-win drivers → molto più veloce dei driver IDE/standard

SSD NVMe dedicato → performance massime

🚀 Benefici finali

1 host Fedora ultra-stabile

3–4 VM Windows con ottime prestazioni

GPU host dedicata (NVIDIA)

Accelerazione grafica guest tramite virtio-gpu

Condivisione cartelle efficiente (SPICE/WebDAV/SMB)

Checkpoint delle VM per ripristino rapido

Aggiornamenti separati per ogni ambiente industriale

Zero conflitti tra software SCADA/PLC

📦 Preparazione Template Win11

La prima VM Windows 11 (“Win11-Template”) serve per:

installare driver virtIO

attivare Windows

configurare ottimizzazioni (power, rete, RDP)

installare tool di base

Poi viene clonata in:

Win11-Rockwell

Win11-Omron

Win11-Schneider

Win11-Office

🌟 Conclusione

Il setup scelto è:

l’unico che permette stabilità + multi-VM + accelerazione grafica + rete industriale

compatibile con il tuo hardware

perfetto per sviluppo PLC/SCADA virtualizzato

E soprattutto evita i limiti della GPU Nvidia e la rimozione di GVT-g dai kernel recenti.
