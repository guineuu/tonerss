import std/htmlparser
import std/xmltree
import std/strutils
import std/httpclient

proc getImpresora*(ip: string): XmlNode =
    var client = newHttpClient()
    let ruta = client.getContent("http://172.19.3." & ip & "/cgi-bin/dynamic/printer/PrinterStatus.html")
    writeFile("temp.html", ruta)
    return loadHtml("temp.html")

proc getTinta*(html: XmlNode): int =
    for b in html.findAll("b"):
        let texto = $b
        if texto.contains("Cartucho negro"):
            let valor = texto.split({' ', '<', '~', '%'})
            return parseInt(valor[5])
