import std/htmlparser
import std/xmltree
import std/strutils
import std/httpclient

proc getImpresora*(ip: string): XmlNode =
    var client = newHttpClient()
    let ruta = client.getContent("http://172.19.3." & ip & "/cgi-bin/dynamic/printer/PrinterStatus.html")
    writeFile("temp.html", ruta)
    return loadHtml("temp.html")

proc getEstado*(html: XmlNode): array[3, int] =
    var estado: array[3, int]
    var valor: seq[string]
    for b in html.findAll("b"):
        let texto = $b
        if texto.contains("Cartucho negro"):
            valor = texto.split({' ', '<', '~', '%'})
            estado[0] = parseInt(valor[5])
    for tr in html.findAll("tr"):
        let texto = $tr
        if texto.contains("td"):
            if texto.contains("b"):
                if texto.contains("Kit mantenimient"):
                    valor = texto.split({'<', '>', '%'})
                    estado[1] = parseInt(valor[12])
                elif texto.contains("Unidad imagen"):
                    valor = texto.split({'<', '>', '%'})
                    estado[2] = parseInt(valor[12])
    return estado