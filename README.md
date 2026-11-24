# Control de Activos Fijos · Preparación para Visita Domiciliaria

Herramienta web de un solo archivo (`index.html`) para llevar el control del inventario de activos fijos y prepararse para una visita domiciliaria del SAT enfocada en activos fijos.

## Instalación con actualización automática (Windows, recomendado)
1. Descargue `instalador/ACM_Activos_Fijos.cmd` y ábralo con doble clic. Si Windows muestra «Windows protegió su PC», elija **Más información → Ejecutar de todas formas**.
2. Se instala en `%LOCALAPPDATA%\ACM\ActivosFijos` y crea en el Escritorio el acceso directo **«ACM Activos Fijos»** (reemplaza uno anterior con el mismo nombre; el viejo se guarda como `acceso_directo_anterior.lnk`).
3. Cada vez que abra ese acceso directo, descarga la versión más reciente del programa, del ícono y del propio lanzador desde GitHub y la abre (en Chrome; si no está instalado, en Edge). Sin internet, abre la última copia descargada. Solo se descarga el programa: sus datos no se suben ni se descargan.

## Cómo abrirla (manual)
1. Descargue `index.html`.
2. Ábralo con doble clic en Chrome, Edge o Firefox. No requiere instalación ni internet.
3. **Guardar en su computadora (recomendado):** pestaña **Respaldo → «Elegir carpeta en mi computadora»** (requiere Google Chrome o Microsoft Edge). Desde ese momento cada cambio se graba automáticamente en esa carpeta:
   - `activos_fijos_datos.json` – toda la información.
   - `imagenes/` – fotos de activos y croquis.
   - `respaldos/` – una copia por día y copias automáticas antes de borrar o restaurar.
   Al abrir la herramienta en otra sesión, pulse **«Reconectar»** (el navegador pide confirmar el acceso). Para que nada salga del equipo, elija una carpeta no sincronizada con OneDrive, Google Drive, iCloud o Dropbox.
4. Sin carpeta elegida, los datos quedan solo en el navegador; use **«Descargar respaldo»** para conservar una copia.

## Módulos
| Pestaña | Para qué sirve |
|---|---|
| Inicio | Indicadores y riesgos críticos. |
| Configuración | Datos del contribuyente, orden de visita, saldo de balanza (conciliación) y topes de automóviles. |
| Activos | Registro auxiliar: identificación, CFDI, MOI, inicio de uso, origen (nacional / importación definitiva / temporal IMMEX), ubicación, expediente documental, **fotografías** (cámara del celular o archivo; vista general, placa, serie, etc.) y bajas. Botón **Ficha** para imprimir la ficha del activo con sus fotos. |
| INPC | Captura de INPC oficial (no viene precargado para no usar datos sin verificar). |
| Depreciación | Cédula de deducción de inversiones del ejercicio: meses completos, límite al MOI, factor de actualización (art. 31 LISR, art. 17-A CFF) y comparación contra lo declarado. |
| Conteo físico | Hoja de inventario por ubicación, localizados / no localizados y bienes sobrantes. |
| Croquis de planta | Carga de croquis o planos (PNG/JPG) por planta, nave o bodega; ubicación de cada activo con un punto sobre el plano; marcado de localizado / no localizado durante el recorrido (se refleja en el conteo); impresión del croquis con su lista. |
| Alertas | Hallazgos automáticos por activo (sin CFDI, sin pedimento, efectivo, sin evidencia de inicio de uso, temporales IMMEX sin control, bajas sin soporte, etc.). |
| Visita domiciliaria | Checklist antes / durante / después, con fundamento, notas y referencia del plazo de 20 días hábiles (art. 46 fr. IV CFF). |
| Guía | Explicación de la visita, conceptos (MOI, depreciación contable vs. fiscal), tasas, derechos del contribuyente, errores frecuentes y temas IMMEX. |
| Respaldo | Respaldo/restauración JSON, importación CSV y datos de ejemplo. |

## Advertencias
- Tasas, topes y fundamentos se incluyen como **referencia** y están marcados «verificar vigencia». Contrástelos con el texto vigente publicado en el DOF para el ejercicio revisado.
- El cálculo de plazos solo excluye sábados y domingos; no considera días inhábiles oficiales.
- La herramienta no sustituye la revisión de su contador, abogado o asesor fiscal.
