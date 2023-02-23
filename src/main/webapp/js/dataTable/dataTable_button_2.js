(function(e) {
    "function" === typeof define && define.amd ? define(["jquery", "datatables.net", "datatables.net-buttons"], function(i) {
        return e(i, window, document)
    }) : "object" === typeof exports ? module.exports = function(i, l, t, s) {
        i || (i = window);
        if (!l || !l.fn.dataTable) l = require("datatables.net")(i, l).$;
        l.fn.dataTable.Buttons || require("datatables.net-buttons")(i, l);
        return e(l, i, i.document, t, s)
    } : e(jQuery, window, document)
})(function(e, i, l, t, s, q) {
    function y(a) {
        for (var b = ""; 0 <= a;) b = String.fromCharCode(a % 26 + 65) + b, a = Math.floor(a /
            26) - 1;
        return b
    }

    function z(a, b) {
        u === q && (u = -1 === x.serializeToString(e.parseXML(A["xl/worksheets/sheet1.xml"])).indexOf("xmlns:r"));
        e.each(b, function(d, c) {
            if (e.isPlainObject(c)) {
                var b = a.folder(d);
                z(b, c)
            } else {
                if (u) {
                    var b = c.childNodes[0],
                        h, g, v = [];
                    for (h = b.attributes.length - 1; 0 <= h; h--) {
                        g = b.attributes[h].nodeName;
                        var f = b.attributes[h].nodeValue; - 1 !== g.indexOf(":") && (v.push({
                            name: g,
                            value: f
                        }), b.removeAttribute(g))
                    }
                    h = 0;
                    for (g = v.length; h < g; h++) f = c.createAttribute(v[h].name.replace(":", "_dt_b_namespace_token_")),
                        f.value = v[h].value, b.setAttributeNode(f)
                }
                b = x.serializeToString(c);
                u && (-1 === b.indexOf("<?xml") && (b = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + b), b = b.replace(/_dt_b_namespace_token_/g, ":"));
                b = b.replace(/<([^<>]*?) xmlns=""([^<>]*?)>/g, "<$1 $2>");
                a.file(d, b)
            }
        })
    }

    function o(a, b, d) {
        var c = a.createElement(b);
        d && (d.attr && e(c).attr(d.attr), d.children && e.each(d.children, function(a, b) {
            c.appendChild(b)
        }), null !== d.text && d.text !== q && c.appendChild(a.createTextNode(d.text)));
        return c
    }

    function J(a, b) {
        var d =
            a.header[b].length,
            c;
        a.footer && a.footer[b].length > d && (d = a.footer[b].length);
        for (var e = 0, h = a.body.length; e < h; e++)
            if (c = a.body[e][b], c = null !== c && c !== q ? c.toString() : "", -1 !== c.indexOf("\n") ? (c = c.split("\n"), c.sort(function(a, b) {
                    return b.length - a.length
                }), c = c[0].length) : c = c.length, c > d && (d = c), 40 < d) return 52;
        d *= 1.3;
        return 6 < d ? d : 6
    }
    var p = e.fn.dataTable,
        r;
    var f = "undefined" !== typeof self && self || "undefined" !== typeof i && i || this.content;
    if ("undefined" === typeof f || "undefined" !== typeof navigator && /MSIE [1-9]\./.test(navigator.userAgent)) r =
        void 0;
    else {
        var w = f.document.createElementNS("http://www.w3.org/1999/xhtml", "a"),
            K = "download" in w,
            L = /constructor/i.test(f.HTMLElement) || f.safari,
            B = /CriOS\/[\d]+/.test(navigator.userAgent),
            M = function(a) {
                (f.setImmediate || f.setTimeout)(function() {
                    throw a;
                }, 0)
            },
            C = function(a) {
                setTimeout(function() {
                    "string" === typeof a ? (f.URL || f.webkitURL || f).revokeObjectURL(a) : a.remove()
                }, 4E4)
            },
            D = function(a) {
                return /^\s*(?:text\/\S*|application\/xml|\S*\/\S*\+xml)\s*;.*charset\s*=\s*utf-8/i.test(a.type) ? new Blob([String.fromCharCode(65279),
                    a
                ], {
                    type: a.type
                }) : a
            },
            E = function(a, b, d) {
                d || (a = D(a));
                var c = this,
                    d = "application/octet-stream" === a.type,
                    e, h = function() {
                        for (var a = ["writestart", "progress", "write", "writeend"], a = [].concat(a), b = a.length; b--;) {
                            var d = c["on" + a[b]];
                            if ("function" === typeof d) try {
                                d.call(c, c)
                            } catch (g) {
                                M(g)
                            }
                        }
                    };
                c.readyState = c.INIT;
                if (K) e = (f.URL || f.webkitURL || f).createObjectURL(a), setTimeout(function() {
                    w.href = e;
                    w.download = b;
                    var a = new MouseEvent("click");
                    w.dispatchEvent(a);
                    h();
                    C(e);
                    c.readyState = c.DONE
                });
                else if ((B || d && L) && f.FileReader) {
                    var g =
                        new FileReader;
                    g.onloadend = function() {
                        var a = B ? g.result : g.result.replace(/^data:[^;]*;/, "data:attachment/file;");
                        f.open(a, "_blank") || (f.location.href = a);
                        c.readyState = c.DONE;
                        h()
                    };
                    g.readAsDataURL(a);
                    c.readyState = c.INIT
                } else e || (e = (f.URL || f.webkitURL || f).createObjectURL(a)), d ? f.location.href = e : f.open(e, "_blank") || (f.location.href = e), c.readyState = c.DONE, h(), C(e)
            },
            k = E.prototype;
        "undefined" !== typeof navigator && navigator.msSaveOrOpenBlob ? r = function(a, b, d) {
            b = b || a.name || "download";
            d || (a = D(a));
            return navigator.msSaveOrOpenBlob(a,
                b)
        } : (k.abort = function() {}, k.readyState = k.INIT = 0, k.WRITING = 1, k.DONE = 2, k.error = k.onwritestart = k.onprogress = k.onwrite = k.onabort = k.onerror = k.onwriteend = null, r = function(a, b, d) {
            return new E(a, b || a.name || "download", d)
        })
    }
    p.fileSave = r;
    var N = function(a) {
            var b = "Sheet1";
            a.sheetName && (b = a.sheetName.replace(/[\[\]\*\/\\\?\:]/g, ""));
            return b
        },
        F = function(a) {
            return a.newline ? a.newline : navigator.userAgent.match(/Windows/) ? "\r\n" : "\n"
        },
        G = function(a, b) {
            for (var d = F(b), c = a.buttons.exportData(b.exportOptions), e = b.fieldBoundary,
                    h = b.fieldSeparator, g = RegExp(e, "g"), f = b.escapeChar !== q ? b.escapeChar : "\\", i = function(a) {
                        for (var b = "", c = 0, d = a.length; c < d; c++) 0 < c && (b += h), b += e ? e + ("" + a[c]).replace(g, f + e) + e : a[c];
                        return b
                    }, l = b.header ? i(c.header) + d : "", j = b.footer && c.footer ? d + i(c.footer) : "", n = [], m = 0, k = c.body.length; m < k; m++) n.push(i(c.body[m]));
            return {
                str: l + n.join(d) + j,
                rows: n.length
            }
        },
        H = function() {
            if (!(-1 !== navigator.userAgent.indexOf("Safari") && -1 === navigator.userAgent.indexOf("Chrome") && -1 === navigator.userAgent.indexOf("Opera"))) return !1;
            var a = navigator.userAgent.match(/AppleWebKit\/(\d+\.\d+)/);
            return a && 1 < a.length && 603.1 > 1 * a[1] ? !0 : !1
        };
    try {
        var x = new XMLSerializer,
            u
    } catch (O) {}
    var A = {
            "_rels/.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>',
            "xl/_rels/workbook.xml.rels": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/></Relationships>',
            "[Content_Types].xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="xml" ContentType="application/xml" /><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml" /><Default Extension="jpeg" ContentType="image/jpeg" /><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml" /><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml" /><Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml" /></Types>',
            "xl/workbook.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><fileVersion appName="xl" lastEdited="5" lowestEdited="5" rupBuild="24816"/><workbookPr showInkAnnotation="0" autoCompressPictures="0"/><bookViews><workbookView xWindow="0" yWindow="0" windowWidth="25600" windowHeight="19020" tabRatio="500"/></bookViews><sheets><sheet name="" sheetId="1" r:id="rId1"/></sheets></workbook>',
            "xl/worksheets/sheet1.xml": '<?xml version="1.0" encoding="UTF-8" standalone="yes"?><worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac"><sheetData/><mergeCells count="0"/></worksheet>',
            "xl/styles.xml": '<?xml version="1.0" encoding="UTF-8"?><styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" mc:Ignorable="x14ac" xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac"><numFmts count="6"><numFmt numFmtId="164" formatCode="#,##0.00_- [$$-45C]"/><numFmt numFmtId="165" formatCode="&quot;£&quot;#,##0.00"/><numFmt numFmtId="166" formatCode="[$€-2] #,##0.00"/><numFmt numFmtId="167" formatCode="0.0%"/><numFmt numFmtId="168" formatCode="#,##0;(#,##0)"/><numFmt numFmtId="169" formatCode="#,##0.00;(#,##0.00)"/></numFmts><fonts count="5" x14ac:knownFonts="1"><font><sz val="11" /><name val="Calibri" /></font><font><sz val="11" /><name val="Calibri" /><color rgb="FFFFFFFF" /></font><font><sz val="11" /><name val="Calibri" /><b /></font><font><sz val="11" /><name val="Calibri" /><i /></font><font><sz val="11" /><name val="Calibri" /><u /></font></fonts><fills count="6"><fill><patternFill patternType="none" /></fill><fill><patternFill patternType="none" /></fill><fill><patternFill patternType="solid"><fgColor rgb="FFD9D9D9" /><bgColor indexed="64" /></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="FFD99795" /><bgColor indexed="64" /></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="ffc6efce" /><bgColor indexed="64" /></patternFill></fill><fill><patternFill patternType="solid"><fgColor rgb="ffc6cfef" /><bgColor indexed="64" /></patternFill></fill></fills><borders count="2"><border><left /><right /><top /><bottom /><diagonal /></border><border diagonalUp="false" diagonalDown="false"><left style="thin"><color auto="1" /></left><right style="thin"><color auto="1" /></right><top style="thin"><color auto="1" /></top><bottom style="thin"><color auto="1" /></bottom><diagonal /></border></borders><cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" /></cellStyleXfs><cellXfs count="67"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="2" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="2" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="2" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="2" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="2" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="3" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="3" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="3" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="3" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="3" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="4" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="4" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="4" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="4" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="4" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="5" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="5" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="5" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="5" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="5" borderId="0" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="0" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="0" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="0" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="0" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="0" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="2" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="3" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="3" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="3" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="3" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="3" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="4" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="4" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="4" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="4" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="4" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="5" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="1" fillId="5" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="2" fillId="5" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="3" fillId="5" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="4" fillId="5" borderId="1" applyFont="1" applyFill="1" applyBorder="1"/><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment horizontal="left"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment horizontal="center"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment horizontal="right"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment horizontal="fill"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment textRotation="90"/></xf><xf numFmtId="0" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyAlignment="1"><alignment wrapText="1"/></xf><xf numFmtId="9"   fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="164" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="165" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="166" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="167" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="168" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="169" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="3" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="4" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="1" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/><xf numFmtId="2" fontId="0" fillId="0" borderId="0" applyFont="1" applyFill="1" applyBorder="1" xfId="0" applyNumberFormat="1"/></cellXfs><cellStyles count="1"><cellStyle name="Normal" xfId="0" builtinId="0" /></cellStyles><dxfs count="0" /><tableStyles count="0" defaultTableStyle="TableStyleMedium9" defaultPivotStyle="PivotStyleMedium4" /></styleSheet>'
        },
        I = [{
                match: /^\-?\d+\.\d%$/,
                style: 60,
                fmt: function(a) {
                    return a / 100
                }
            }, {
                match: /^\-?\d+\.?\d*%$/,
                style: 56,
                fmt: function(a) {
                    return a / 100
                }
            }, {
                match: /^\-?\$[\d,]+.?\d*$/,
                style: 57
            }, {
                match: /^\-?£[\d,]+.?\d*$/,
                style: 58
            }, {
                match: /^\-?€[\d,]+.?\d*$/,
                style: 59
            }, {
                match: /^\-?\d+$/,
                style: 65
            }, {
                match: /^\-?\d+\.\d{2}$/,
                style: 66
            }, {
                match: /^\([\d,]+\)$/,
                style: 61,
                fmt: function(a) {
                    return -1 * a.replace(/[\(\)]/g, "")
                }
            }, {
                match: /^\([\d,]+\.\d{2}\)$/,
                style: 62,
                fmt: function(a) {
                    return -1 * a.replace(/[\(\)]/g, "")
                }
            }, {
                match: /^\-?[\d,]+$/,
                style: 63
            },
            {
                match: /^\-?[\d,]+\.\d{2}$/,
                style: 64
            }
        ];
    p.ext.buttons.copyHtml5 = {
        className: "buttons-copy buttons-html5",
        text: function(a) {
            return a.i18n("buttons.copy", "Copy")
        },
        action: function(a, b, d, c) {
            this.processing(!0);
            var f = this,
                a = G(b, c),
                h = b.buttons.exportInfo(c),
                g = F(c),
                i = a.str,
                d = e("<div/>").css({
                    height: 1,
                    width: 1,
                    overflow: "hidden",
                    position: "fixed",
                    top: 0,
                    left: 0
                });
            h.title && (i = h.title + g + g + i);
            h.messageTop && (i = h.messageTop + g + g + i);
            h.messageBottom && (i = i + g + g + h.messageBottom);
            c.customize && (i = c.customize(i, c));
            c = e("<textarea readonly/>").val(i).appendTo(d);
            if (l.queryCommandSupported("copy")) {
                d.appendTo(b.table().container());
                c[0].focus();
                c[0].select();
                try {
                    var k = l.execCommand("copy");
                    d.remove();
                    if (k) {
                        b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), b.i18n("buttons.copySuccess", {
                            1: "Copied one row to clipboard",
                            _: "Copied %d rows to clipboard"
                        }, a.rows), 2E3);
                        this.processing(!1);
                        return
                    }
                } catch (o) {}
            }
            k = e("<span>" + b.i18n("buttons.copyKeys", "Press <i>ctrl</i> or <i>⌘</i> + <i>C</i> to copy the table data<br>to your system clipboard.<br><br>To cancel, click this message or press escape.") +
                "</span>").append(d);
            b.buttons.info(b.i18n("buttons.copyTitle", "Copy to clipboard"), k, 0);
            c[0].focus();
            c[0].select();
            var j = e(k).closest(".dt-button-info"),
                n = function() {
                    j.off("click.buttons-copy");
                    e(l).off(".buttons-copy");
                    b.buttons.info(!1)
                };
            j.on("click.buttons-copy", n);
            e(l).on("keydown.buttons-copy", function(a) {
                27 === a.keyCode && (n(), f.processing(!1))
            }).on("copy.buttons-copy cut.buttons-copy", function() {
                n();
                f.processing(!1)
            })
        },
        exportOptions: {},
        fieldSeparator: "\t",
        fieldBoundary: "",
        header: !0,
        footer: !1,
        title: "*",
        messageTop: "*",
        messageBottom: "*"
    };
    p.ext.buttons.csvHtml5 = {
        bom: !1,
        className: "buttons-csv buttons-html5",
        available: function() {
            return i.FileReader !== q && i.Blob
        },
        text: function(a) {
            return a.i18n("buttons.csv", "CSV")
        },
        action: function(a, b, d, c) {
            this.processing(!0);
            a = G(b, c).str;
            b = b.buttons.exportInfo(c);
            d = c.charset;
            c.customize && (a = c.customize(a, c));
            !1 !== d ? (d || (d = l.characterSet || l.charset), d && (d = ";charset=" + d)) : d = "";
            c.bom && (a = "﻿" + a);
            r(new Blob([a], {
                type: "text/csv" + d
            }), b.filename, !0);
            this.processing(!1)
        },
        filename: "*",
        extension: ".csv",
        exportOptions: {},
        fieldSeparator: ",",
        fieldBoundary: '"',
        escapeChar: '"',
        charset: null,
        header: !0,
        footer: !1
    };
    p.ext.buttons.excelHtml5 = {
        className: "buttons-excel buttons-html5",
        available: function() {
            return i.FileReader !== q && (t || i.JSZip) !== q && !H() && x
        },
        text: function(a) {
            return a.i18n("buttons.excel", "Excel")
        },
        action: function(a, b, d, c) {
            this.processing(!0);
            var f = this,
                h = 0,
                a = function(a) {
                    return e.parseXML(A[a])
                },
                g = a("xl/worksheets/sheet1.xml"),
                k = g.getElementsByTagName("sheetData")[0],
                a = {
                    _rels: {
                        ".rels": a("_rels/.rels")
                    },
                    xl: {
                        _rels: {
                            "workbook.xml.rels": a("xl/_rels/workbook.xml.rels")
                        },
                        "workbook.xml": a("xl/workbook.xml"),
                        "styles.xml": a("xl/styles.xml"),
                        worksheets: {
                            "sheet1.xml": g
                        }
                    },
                    "[Content_Types].xml": a("[Content_Types].xml")
                },
                d = b.buttons.exportData(c.exportOptions),
                l, p, j = function(a) {
                    l = h + 1;
                    p = o(g, "row", {
                        attr: {
                            r: l
                        }
                    });
                    for (var b = 0, d = a.length; b < d; b++) {
                        var i = y(b) + "" + l,
                            f = null;
                        if (null === a[b] || a[b] === q || "" === a[b])
                            if (!0 === c.createEmptyCells) a[b] = "";
                            else continue;
                        a[b] = e.trim(a[b]);
                        for (var j =
                                0, n = I.length; j < n; j++) {
                            var m = I[j];
                            if (a[b].match && !a[b].match(/^0\d+/) && a[b].match(m.match)) {
                                f = a[b].replace(/[^\d\.\-]/g, "");
                                m.fmt && (f = m.fmt(f));
                                f = o(g, "c", {
                                    attr: {
                                        r: i,
                                        s: m.style
                                    },
                                    children: [o(g, "v", {
                                        text: f
                                    })]
                                });
                                break
                            }
                        }
                        f || ("number" === typeof a[b] || a[b].match && a[b].match(/^-?\d+(\.\d+)?$/) && !a[b].match(/^0\d+/) ? f = o(g, "c", {
                            attr: {
                                t: "n",
                                r: i
                            },
                            children: [o(g, "v", {
                                text: a[b]
                            })]
                        }) : (m = !a[b].replace ? a[b] : a[b].replace(/[\x00-\x09\x0B\x0C\x0E-\x1F\x7F-\x9F]/g, ""), f = o(g, "c", {
                            attr: {
                                t: "inlineStr",
                                r: i
                            },
                            children: {
                                row: o(g,
                                    "is", {
                                        children: {
                                            row: o(g, "t", {
                                                text: m
                                            })
                                        }
                                    })
                            }
                        })));
                        p.appendChild(f)
                    }
                    k.appendChild(p);
                    h++
                };
            e("sheets sheet", a.xl["workbook.xml"]).attr("name", N(c));
            c.customizeData && c.customizeData(d);
            var n = function(a, b) {
                    var c = e("mergeCells", g);
                    c[0].appendChild(o(g, "mergeCell", {
                        attr: {
                            ref: "A" + a + ":" + y(b) + a
                        }
                    }));
                    c.attr("count", parseFloat(c.attr("count")) + 1);
                    e("row:eq(" + (a - 1) + ") c", g).attr("s", "51")
                },
                m = b.buttons.exportInfo(c);
            m.title && (j([m.title], h), n(h, d.header.length - 1));
            m.messageTop && (j([m.messageTop], h), n(h, d.header.length -
                1));
            c.header && (j(d.header, h), e("row:last c", g).attr("s", "2"));
            for (var b = 0, s = d.body.length; b < s; b++) j(d.body[b], h);
            c.footer && d.footer && (j(d.footer, h), e("row:last c", g).attr("s", "2"));
            m.messageBottom && (j([m.messageBottom], h), n(h, d.header.length - 1));
            b = o(g, "cols");
            e("worksheet", g).prepend(b);
            j = 0;
            for (n = d.header.length; j < n; j++) b.appendChild(o(g, "col", {
                attr: {
                    min: j + 1,
                    max: j + 1,
                    width: J(d, j),
                    customWidth: 1
                }
            }));
            c.customize && c.customize(a);
            0 === e("mergeCells", g).children().length && e("mergeCells", g).remove();
            d = new(t ||
                i.JSZip);
            b = {
                type: "blob",
                mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            };
            z(d, a);
            d.generateAsync ? d.generateAsync(b).then(function(a) {
                r(a, m.filename);
                f.processing(false)
            }) : (r(d.generate(b), m.filename), this.processing(!1))
        },
        filename: "*",
        extension: ".xlsx",
        exportOptions: {},
        header: !0,
        footer: !1,
        title: "*",
        messageTop: "*",
        messageBottom: "*",
        createEmptyCells: !1
    };
    p.ext.buttons.pdfHtml5 = {
        className: "buttons-pdf buttons-html5",
        available: function() {
            return i.FileReader !== q && (s || i.pdfMake)
        },
        text: function(a) {
            return a.i18n("buttons.pdf", "PDF")
        },
        action: function(a, b, d, c) {
            this.processing(!0);
            a = b.buttons.exportData(c.exportOptions);
            b = b.buttons.exportInfo(c);
            d = [];
            c.header && d.push(e.map(a.header, function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: "tableHeader"
                }
            }));
            for (var f = 0, h = a.body.length; f < h; f++) d.push(e.map(a.body[f], function(a) {
                return {
                    text: "string" === typeof a ? a : a + "",
                    style: f % 2 ? "tableBodyEven" : "tableBodyOdd"
                }
            }));
            c.footer && a.footer && d.push(e.map(a.footer, function(a) {
                return {
                    text: "string" ===
                        typeof a ? a : a + "",
                    style: "tableFooter"
                }
            }));
            a = {
                pageSize: c.pageSize,
                pageOrientation: c.orientation,
                content: [{
                    table: {
                        headerRows: 1,
                        body: d
                    },
                    layout: "noBorders"
                }],
                styles: {
                    tableHeader: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154",
                        alignment: "center"
                    },
                    tableBodyEven: {},
                    tableBodyOdd: {
                        fillColor: "#f3f3f3"
                    },
                    tableFooter: {
                        bold: !0,
                        fontSize: 11,
                        color: "white",
                        fillColor: "#2d4154"
                    },
                    title: {
                        alignment: "center",
                        fontSize: 15
                    },
                    message: {}
                },
                defaultStyle: {
                    fontSize: 10
                }
            };
            b.messageTop && a.content.unshift({
                text: b.messageTop,
                style: "message",
                margin: [0, 0, 0, 12]
            });
            b.messageBottom && a.content.push({
                text: b.messageBottom,
                style: "message",
                margin: [0, 0, 0, 12]
            });
            b.title && a.content.unshift({
                text: b.title,
                style: "title",
                margin: [0, 0, 0, 12]
            });
            c.customize && c.customize(a, c);
            a = (s || i.pdfMake).createPdf(a);
            "open" === c.download && !H() ? a.open() : a.download(b.filename);
            this.processing(!1)
        },
        title: "*",
        filename: "*",
        extension: ".pdf",
        exportOptions: {},
        orientation: "portrait",
        pageSize: "A4",
        header: !0,
        footer: !1,
        messageTop: "*",
        messageBottom: "*",
        customize: null,
        download: "download"
    };
    return p.Buttons
});