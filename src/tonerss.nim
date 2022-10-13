import impresoras
import yaml/serialization, streams
import terminaltables
import colorize
import pronimgress
import strutils

# Crear tabla
let taula = newUnicodeTable()
taula.setHeaders(@[newCell("CS"), newCell("Ubicación", rightpad=5), newCell("Tinta restante", rightpad=5), newCell("Estado")])
type Impresora = object
  lloc: string
  id: string

# Cargar YAML con las impresoras
var llistaImpresores: seq[Impresora]
var llista = newFileStream("llista.yml")
load(llista, llistaImpresores)

# Crear barra de progreso
var progressBar = newPronimgressBar(
  prefix = "Procesando...",
  leftSurroundChar = '|',
  rightSurroundChar = '|',
  backgroundChar = ' ',
  progressChar = '-',
  progressHeadChar = '>',
  size = strutils.parseFloat($llistaImpresores.len())
)


# Añadir filas a la tabla
var checkCount = 0
var msg = "Inicializando..."
for impressora in llistaImpresores:
  let html = impresoras.getImpresora(impressora.id)
  var tinta = getTinta(html)
  msg = fgWhite("CS " & impressora.id)
  progressBar.update(1, msg)

  var check = "✔"

  if tinta < 10:
    check = "!"
    checkCount += 1

  taula.addRow(@[impressora.id, impressora.lloc, $tinta & "%", check])

progressBar.update(1, "Completado".fgGreen())
# Printar la tinta
echo(fgBlue("\n\ntonerss - por Roger Gras"))
echo(fgCyan("\nIneo Develop 4700P").bold())
printTable(taula)
echo fgRed($checkCount & " impresoras con menos del 10% de tinta.")

llista.close()