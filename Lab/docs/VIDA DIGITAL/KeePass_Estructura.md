# Estructura KeePass

## Objetivo del documento

Este documento define la estructura de grupos y entradas de KeePass para organizar credenciales, contraseñas y secretos digitales, alineada con la estructura de carpetas de VIDA DIGITAL.

**Propósito:**
- Que las credenciales estén organizadas por contexto de uso
- Que la segmentación de correos sea clara y consistente
- Que el estado de las contraseñas sea visible de un vistazo (emojis)

---

## Estructura de grupos KeePass

La estructura espeja los 6 pilares de VIDA DIGITAL, con algunas adaptaciones para credenciales:

### 00 ADMINISTRACIÓN

Documentos de identidad, certificados digitales y pólizas.

- **00 Documentos de Identidad**
  - 01 Pepe
    - DNIe Pepe PBT
  - 02 Myriam
  - 03 Carla
    - DNIe Carla CBM
- **10 Certificados Digitales**
  - 01 Pepe
    - Certificat Pepe PBT FNMT
    - Cl@ve Pepe PBT
  - 02 Myriam
  - 03 Carla
- **20 Seguros y pólizas**
  - Salud
    - `<Aseguradora>` (ej. MAPFRE)
  - Hogar
  - Vehículo
  - Vida

---

### 10 DINERO

Bancos, tarjetas, impuestos, actividad profesional.

- **00 Admin**
  - Hogar
    - Suministros (Agua, Luz, Gas, Internet)
    - Vehículo
- **10 Actividad Profesional**
  - Clientes
    - `<Nombre Cliente>` (ej. Parroquia San Juan Bautista de Manises)
  - Proveedores
    - `<Nombre Proveedor>` (ej. Menecil)
  - Hacienda
    - Agencia Tributaria (acceso web)
- **20 Bancos y brókeres**
  - Webs
    - `<Entidad>` (ej. 🔠🔐 Banco Santander (Pepe), 🔠🔐 MyInvestor (Pepe))
  - IBANs
    - `<Entidad> ***<últimos 4> (<Titular>)` (ej. MyInvestor ***7967 (Remun. PEPE))
  - Tarjetas
    - `<Tipo> <Titular> (<últimos 4>)` (ej. Master Pepe (6807) / Santander Zero)
  - Wallets
    - `<Tipo> <ID>` (ej. 📲 CW01, 🌱 HW01 Metamask)
- **30 Inversiones y cartera**
  - `<Plataforma>` (ej. 🔠🔐 Portfolio Performance (API y Foro))

---

### 20 SALUD

Proveedores sanitarios, apps de salud, accesos de Carla.

- **00 Admin**
  - Seguridad Social
    - SIP - Pepe
    - SIP CBM (Carla)
  - Seguros Médicos
    - `<Aseguradora>` (ej. Sanitas, MAPFRE Salud)
- **10 Proveedores sanitarios**
  - `<Proveedor>` (ej. Web IMED - Pepe, Web Quironsalud)
- **20 Apps y servicios**
  - `<App>` (ej. App GVA +Salud, Gympass Wellhub)
- **30 Ejercicio**
  - `<Servicio>` (ej. 🔠🔒 BBH Wodbuster (Crossfit) (jborrast))

---

### 30 RELACIONES

Familia, colegio, ocio y viajes.

- **00 Familia Núcleo**
  - Carla
    - Colegio
      - `<Plataforma>` (ej. Educamos, BlinkLearning, Duolingo Carla)
    - Actividades
      - `<Actividad>` (ej. Smartick Carla)
  - Myriam
    - Educación
      - `<Institución>` (ej. EOI, AIMME)
- **10 Ocio y Viajes**
  - `<Servicio>` (ej. Disney+, Spotify, Booking, Vueling)
- **20 Historia Familiar**
  - ADN y genealogía
    - `<Servicio>` (ej. 23andme, FamilyTreeDNA, GEDmatch)

---

### 40 DESARROLLO PERSONAL

Formación, escritura, asociaciones.

- **00 Formación**
  - `<Curso o Plataforma>` (ej. 🔒 Cerebro Digital de Emowe, Coursera Capgemini)
- **10 Creatividad y Escritura**
  - `<Plataforma>` (ej. Canva, Wordpress)
- **20 Asociaciones**
  - Valencianismo
    - Lo Rat Penat
      - `<Servicio>` (ej. NT LRP (Gmail), Web LRP (pep))
    - Trellat
      - `<Servicio>` (ej. Wordpress Trellat.org (Administrador))

---

### 90 SISTEMA

Correo y Alias, Dominios y Hosting, Infraestructura, Software y Apps.

- **10 Correo y Alias**
  - 🔒 Core Email
    - `<Correo>` (ej. 🔠🔐 Proton CORE (jbt.focus31@proton.me))
  - 📬 Personal principal
    - `<Correo>` (ej. 🔠🔒 Gmail - jborrast)
  - 💼 Profesional
    - `<Correo>` (ej. Capgemini - CORP/jborrast)
  - 🚀 Plan B / Negocio
    - `<Correo>` (ej. 🔠🧪 Gmail - focus31.lab)
  - 🎭 Suscripciones / Público
    - `<Correo>` (ej. Yahoo - jborrast@yahoo.es)
- **20 Dominios y Hosting**
  - `<Dominio>` (ej. 🔠🔐 Cloudflare (focus31.lab@gmail.com), 🔠🔐 Hostinger)
- **30 Infraestructura**
  - OneDrive
  - Google Drive
  - n8n
    - `<Instancia>` (ej. 🔠🧪 n8n (Mini PC), 🔠🧪 n8n (SaaS) (focus31-lab-1))
  - Cloudflare
    - `<Servicio>` (ej. 🔠🧪 Cloudflare Tunnel (Mini_PC))
  - Docker
    - `<Servicio>` (ej. 🔠🧪 PostgreSQL (Mini PC), 🔠🧪 Duplicati (Mini PC))
  - Monitorización
    - `<Servicio>` (ej. 🔠🧪 HealthChecks.io, UptimeRobot.com)
- **40 Software y Apps**
  - `<Categoría>`
    - `<App>` (ej. OpenAI, GitHub, Docker, Canva, Gamma.app, Napkin)
- **50 Seguridad**
  - `<Servicio>` (ej. My ESET, My Kaspersky, ListaRobinson)
- **60 Dispositivos**
  - PINs móviles
    - `<Dispositivo>` (ej. Pepe - SIM, Pepe - Móvil Galaxy A33 5G)
  - Windows
    - `<Equipo>` (ej. Pepe - ASUS VivoBook Pro 15, Pepe - Beelink 13th Mini S)
  - Linux
    - `<Equipo>` (ej. Ubuntu Servidor, WSL Ubuntu)
  - Red
    - WiFi
      - `<Red>` (ej. WiFi - Casa BM, WiFi - LBDS)

---

## Segmentación de correos

Todos los correos se ubican en `/90 SISTEMA/10 Correo y Alias`, organizados por tipo:

| Emoji | Tipo | Uso | Ejemplo |
|-------|------|-----|---------|
| 🔒 | **Core Email** | Ultrasecreto; solo para accesos críticos: banca, dominios, gestor contraseñas, identidad oficial | `jbt.focus31@proton.me` |
| 📬 | **Personal principal** | Vida privada, comunicación familiar/amigos | `jborrast@gmail.com` |
| 💼 | **Profesional** | Empresa por cuenta ajena (Capgemini…) | `jose.borras-tortajada@capgemini.com` |
| 🚀 | **Plan B / Negocio** | Correos bajo tus dominios (andana31, josepborras, pborras…) | `info@andana31.com` |
| 🎭 | **Suscripciones / Público** | Amazon, Netflix, foros, newsletters, pruebas | `jborrast+subscriptions@gmail.com` |

---

## Estado de contraseña / SSO

Usa emojis como **sufijo** o **segundo prefijo** en el título de la entrada:

| Emoji | Estado | Descripción |
|-------|--------|-------------|
| ✅ | **Contraseña única, robusta y actualizada** | Contraseña fuerte, única para este servicio, cambiada recientemente |
| 🟢 | **Usa SSO de Google (OK)** | Autenticación con Google; no hay problema |
| 🟡 | **Usa SSO de Google, pero migrar a contraseña única** | Usa SSO ahora, pero se desea independizar la cuenta |
| ⏳ | **Contraseña antigua** | Lleva mucho tiempo sin cambiarse |
| 🚨 | **Contraseña comprometida** | Fuga/alerta HIBP; cambiar urgentemente |

---

## Formato de título KeePass

**Patrón:**  
`<Emoji correo> <correo> — <Servicio> <Emoji estado>`

**Ejemplos:**
- `🚀 info@andana31.com — Canva 🟡`
- `🔒 jbt.focus31@proton.me — Cloudflare ✅`
- `📬 jborrast@gmail.com — Netflix ⏳`
- `💼 jose.borras-tortajada@capgemini.com — Portal del Empleado 🟢`

---

## Reglas de ubicación para nuevas entradas

### 1. Identifica el contexto de uso

> **«¿Para qué usaré este acceso?»**

- **Crítico** (banca, dominios, gestor contraseñas, identidad oficial) → `/00 ADMINISTRACIÓN/` o `/90 SISTEMA/20 Dominios y Hosting/`
- **Vida personal/comunicación** → `/30 RELACIONES/` o `/90 SISTEMA/10 Correo y Alias/`
- **Laboral por cuenta ajena** → `/10 DINERO/10 Actividad Profesional/` (si es cliente) o `/90 SISTEMA/40 Software y Apps/` (si es herramienta)
- **Negocio propio/Plan B** → `/10 DINERO/10 Actividad Profesional/Clientes/` o `/90 SISTEMA/40 Software y Apps/`
- **Consumo/entretenimiento/foros** → `/30 RELACIONES/10 Ocio y Viajes/` o `/90 SISTEMA/40 Software y Apps/`

### 2. Elige el correo según criticidad

| Criticidad | Correo |
|------------|--------|
| Crítico (banca, dominios, gestor contraseñas, identidad oficial) | 🔒 Core |
| Vida personal/comunicación | 📬 Personal |
| Laboral por cuenta ajena | 💼 Profesional |
| Negocio propio/Plan B (clientes, facturación, herramientas del negocio) | 🚀 Plan B |
| Consumo/entretenimiento/foros | 🎭 Suscripciones |

### 3. Marca el estado de la contraseña

- Si la cuenta no es crítica y facilita la vida, **🟢 SSO Google** es aceptable.
- Si el servicio es sensible (pagos, clientes, IP crítica), preferir **✅ contraseña única robusta** y **2FA**.
- Si detectas SSO y te conviene independizar la cuenta → marca **🟡** hasta migrar.

---

## Mapeo: estructura antigua → nueva

Esta tabla muestra cómo migrar entradas de la estructura antigua a la nueva:

| Ruta antigua | Ruta nueva | Comentarios |
|--------------|------------|-------------|
| `Estructura antigua/Identitat/` | `/00 ADMINISTRACIÓN/00 Documentos de Identidad/` | DNIs, pasaportes |
| `Estructura antigua/Oci i Tecnologia/PINs mòvils/` | `/90 SISTEMA/60 Dispositivos/PINs móviles/` | PINs de móviles y tablets |
| `Estructura antigua/Oci i Tecnologia/Seguritat/` | `/90 SISTEMA/50 Seguridad/` | ESET, Kaspersky, ListaRobinson |
| `Estructura antigua/Oci i Tecnologia/Windows/` | `/90 SISTEMA/60 Dispositivos/Windows/` | Contraseñas de equipos Windows |
| `Estructura antigua/Oci i Tecnologia/Linux/` | `/90 SISTEMA/60 Dispositivos/Linux/` | Contraseñas de equipos Linux |
| `Estructura antigua/Oci i Tecnologia/Ret/` | `/90 SISTEMA/60 Dispositivos/Red/WiFi/` | Contraseñas WiFi |
| `Estructura antigua/Oci i Tecnologia/eMail/` | `/90 SISTEMA/10 Correo y Alias/` | Todos los correos, segmentados por tipo |
| `Estructura antigua/Oci i Tecnologia/Oci/` | `/30 RELACIONES/10 Ocio y Viajes/` | Cines, lotería, Disney+ |
| `Estructura antigua/Oci i Tecnologia/Internet/RRSS/` | `/90 SISTEMA/40 Software y Apps/RRSS/` | Twitter, Facebook, LinkedIn, Instagram |
| `Estructura antigua/Oci i Tecnologia/Internet/eCommerce i Transport/` | `/90 SISTEMA/40 Software y Apps/eCommerce/` | Amazon, eBay, AliExpress |
| `Estructura antigua/Oci i Tecnologia/Internet/Oci, viages/` | `/30 RELACIONES/10 Ocio y Viajes/` | Booking, Renfe, Vueling |
| `Estructura antigua/Oci i Tecnologia/Internet/Tech/` | `/90 SISTEMA/40 Software y Apps/Tech/` | OpenAI, GitHub, n8n, Cloudflare |
| `Estructura antigua/Oci i Tecnologia/Internet/Salut i deport/` | `/20 SALUD/30 Ejercicio/` | Virtuagym, Gympass |
| `Estructura antigua/Oci i Tecnologia/Internet/Servicis multimedia/` | `/30 RELACIONES/10 Ocio y Viajes/` | Spotify, Movistar+, Twitch |
| `Estructura antigua/Oci i Tecnologia/Internet/Backup, núvol, remot/` | `/90 SISTEMA/30 Infraestructura/` | Dropbox, TeamViewer, Zoom |
| `Estructura antigua/Oci i Tecnologia/Internet/Llectura, vídeo, àudio/` | `/30 RELACIONES/10 Ocio y Viajes/` | El País, Teatroteca, Àpunt |
| `Estructura antigua/Oci i Tecnologia/Internet/🤖 IA Generativa/` | `/90 SISTEMA/40 Software y Apps/IA Generativa/` | Gamma.app, Napkin |
| `Estructura antigua/Oci i Tecnologia/Productivitat/` | `/90 SISTEMA/40 Software y Apps/Productividad/` | Slack, XMind, Pocket |
| `Estructura antigua/Oci i Tecnologia/Formació/` | `/40 DESARROLLO PERSONAL/00 Formación/` | Certmetrics, Coursera |
| `Estructura antigua/Bancs, Finances, Negocis/Bancs i brokers/` | `/10 DINERO/20 Bancos y brókeres/Webs/` | Bancos, brókeres, PayPal |
| `Estructura antigua/Bancs, Finances, Negocis/CC/` | `/10 DINERO/20 Bancos y brókeres/Webs/` | Exchanges de criptomonedas (Kraken, Binance, Coinbase) |
| `Estructura antigua/Bancs, Finances, Negocis/Social Copy Trading/` | `/10 DINERO/30 Inversiones y cartera/` | eToro |
| `Estructura antigua/Bancs, Finances, Negocis/Fonts Informació/` | `/10 DINERO/30 Inversiones y cartera/` | Morningstar, Rankia, Investing Pro+ |
| `Estructura antigua/Bancs, Finances, Negocis/Inmobiliari/` | `/10 DINERO/20 Bancos y brókeres/Webs/` | Urbanitae, Hausera |
| `Estructura antigua/Negocis/Proveïdors/` | `/10 DINERO/10 Actividad Profesional/Proveedores/` | Hostinger, Náyades |
| `Estructura antigua/Negocis/Proyectes/` | `/10 DINERO/10 Actividad Profesional/Clientes/` | Humano y cIA, GesCem |
| `Estructura antigua/Salut/` | `/20 SALUD/00 Admin/` o `/20 SALUD/10 Proveedores sanitarios/` | SIP, Sanitas, MAPFRE, IMED |
| `Estructura antigua/Salut/ADN i genealogia/` | `/30 RELACIONES/20 Historia Familiar/ADN/` | 23andme, FamilyTreeDNA |
| `Estructura antigua/Salut/Meditació/` | `/40 DESARROLLO PERSONAL/00 Formación/` | Petit Bambou, Meditopia |
| `Estructura antigua/Salut/Menús a domicili/` | `/30 RELACIONES/10 Ocio y Viajes/` | MenuDiet, Wetaca |
| `Estructura antigua/Casa/` | `/10 DINERO/00 Admin/Hogar/Suministros/` | Naturgy, Vodafone, Aguas de Valencia |
| `Estructura antigua/Formació/` | `/40 DESARROLLO PERSONAL/00 Formación/` | Emprende Business School, Cerebro Digital |
| `Estructura antigua/Familia BM/Cole Carla/` | `/30 RELACIONES/00 Familia Núcleo/Carla/Colegio/` | Educamos, BlinkLearning, Duolingo |
| `Estructura antigua/Familia BM/Carla/` | `/30 RELACIONES/00 Familia Núcleo/Carla/` | Google, Roblox, Microsoft |
| `Estructura antigua/Familia BT/` | `/30 RELACIONES/20 Familia Extendida/` | Accesos de los padres |
| `Estructura antigua/Valencianisme/` | `/40 DESARROLLO PERSONAL/20 Asociaciones/Valencianismo/` | Lo Rat Penat, Trellat, Pobret Usuari, AFEDIV |
| `Estructura antigua/Capgemini/` | `/90 SISTEMA/40 Software y Apps/Capgemini/` | Accesos corporativos |
| `Estructura antigua/KeePass/` | `/90 SISTEMA/50 Seguridad/` | Contraseñas maestras de KeePass |

---

## Ejemplos de clasificación

### 1. Nuevo banco: Openbank

**Contexto:** Cuenta bancaria personal.

**Clasificación:**
- **Grupo:** `/10 DINERO/20 Bancos y brókeres/Webs/Openbank`
- **Título:** `🔒 jbt.focus31@proton.me — Openbank ✅`
- **Razón:** Banca crítica → correo Core + contraseña única + 2FA

---

### 2. Acceso al colegio de Carla (Educamos)

**Contexto:** Plataforma educativa del colegio.

**Clasificación:**
- **Grupo:** `/30 RELACIONES/00 Familia Núcleo/Carla/Colegio/Educamos`
- **Título:** `📬 jborrast@gmail.com — Educamos 🟢`
- **Razón:** Vida escolar → correo Personal + SSO Google OK

---

### 3. Canva para el negocio propio

**Contexto:** Herramienta de diseño para materiales de marca.

**Clasificación:**
- **Grupo:** `/90 SISTEMA/40 Software y Apps/Canva`
- **Título:** `🚀 info@andana31.com — Canva 🟡`
- **Razón:** Herramienta del negocio → correo Plan B + SSO a migrar

---

### 4. Netflix

**Contexto:** Streaming de entretenimiento.

**Clasificación:**
- **Grupo:** `/30 RELACIONES/10 Ocio y Viajes/Netflix`
- **Título:** `🎭 jborrast+subscriptions@gmail.com — Netflix ⏳`
- **Razón:** Consumo/ocio → correo Suscripciones + contraseña antigua

---

### 5. Cloudflare (dominio andana31.com)

**Contexto:** Gestión de DNS y túneles del dominio.

**Clasificación:**
- **Grupo:** `/90 SISTEMA/20 Dominios y Hosting/Cloudflare`
- **Título:** `🔒 jbt.focus31@proton.me — Cloudflare ✅`
- **Razón:** Infraestructura crítica → correo Core + contraseña única + 2FA

---

### 6. Portal del Empleado (Capgemini)

**Contexto:** Acceso corporativo de la empresa.

**Clasificación:**
- **Grupo:** `/90 SISTEMA/40 Software y Apps/Capgemini/Portal del Empleado`
- **Título:** `💼 jose.borras-tortajada@capgemini.com — Portal del Empleado 🟢`
- **Razón:** Laboral por cuenta ajena → correo Profesional + SSO corporativo

---

### 7. GitHub (cuenta personal)

**Contexto:** Repositorios personales y del negocio.

**Clasificación:**
- **Grupo:** `/90 SISTEMA/40 Software y Apps/GitHub`
- **Título:** `🚀 focus31.lab@gmail.com — GitHub ✅`
- **Razón:** Herramienta del negocio → correo Plan B + contraseña única + 2FA

---

### 8. Seguro médico MAPFRE

**Contexto:** Acceso web al seguro de salud.

**Clasificación:**
- **Grupo:** `/00 ADMINISTRACIÓN/20 Seguros y pólizas/Salud/MAPFRE`
- **Título:** `🔒 jbt.focus31@proton.me — MAPFRE Salud ✅`
- **Razón:** Datos sanitarios sensibles → correo Core + contraseña única + 2FA
