# Control de Activos Fijos · Preparación para Visita Domiciliaria

Herramienta web de un solo archivo (`index.html`) para llevar el control del inventario de activos fijos y prepararse para una visita domiciliaria del SAT enfocada en activos fijos.

## Cómo abrirla
1. Descargue `index.html`.
2. Ábralo con doble clic en Chrome, Edge o Firefox. No requiere instalación ni internet.
3. Los datos se guardan **solo en ese navegador**. Use la pestaña **Respaldo** para descargar un archivo JSON después de cada sesión.

## Módulos
| Pestaña | Para qué sirve |
|---|---|
| Inicio | Indicadores y riesgos críticos. |
| Configuración | Datos del contribuyente, orden de visita, saldo de balanza (conciliación) y topes de automóviles. |
| Activos | Registro auxiliar: identificación, CFDI, MOI, inicio de uso, origen (nacional / importación definitiva / temporal IMMEX), ubicación, expediente documental y bajas. |
| INPC | Captura de INPC oficial (no viene precargado para no usar datos sin verificar). |
| Depreciación | Cédula de deducción de inversiones del ejercicio: meses completos, límite al MOI, factor de actualización (art. 31 LISR, art. 17-A CFF) y comparación contra lo declarado. |
| Conteo físico | Hoja de inventario por ubicación, localizados / no localizados y bienes sobrantes. |
| Alertas | Hallazgos automáticos por activo (sin CFDI, sin pedimento, efectivo, sin evidencia de inicio de uso, temporales IMMEX sin control, bajas sin soporte, etc.). |
| Visita domiciliaria | Checklist antes / durante / después, con fundamento, notas y referencia del plazo de 20 días hábiles (art. 46 fr. IV CFF). |
| Guía | Explicación de la visita, conceptos (MOI, depreciación contable vs. fiscal), tasas, derechos del contribuyente, errores frecuentes y temas IMMEX. |
| Respaldo | Respaldo/restauración JSON, importación CSV y datos de ejemplo. |

## Advertencias
- Tasas, topes y fundamentos se incluyen como **referencia** y están marcados «verificar vigencia». Contrástelos con el texto vigente publicado en el DOF para el ejercicio revisado.
- El cálculo de plazos solo excluye sábados y domingos; no considera días inhábiles oficiales.
- La herramienta no sustituye la revisión de su contador, abogado o asesor fiscal.
