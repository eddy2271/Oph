/*!
 Buttons for DataTables 1.5.1
 ©2016-2017 SpryMedia Ltd - datatables.net/license
*/
(function(d) {
    "function" === typeof define && define.amd ? define(["jquery", "datatables.net"], function(o) {
        return d(o, window, document)
    }) : "object" === typeof exports ? module.exports = function(o, n) {
        o || (o = window);
        if (!n || !n.fn.dataTable) n = require("datatables.net")(o, n).$;
        return d(n, o, o.document)
    } : d(jQuery, window, document)
})(function(d, o, n, l) {
    var i = d.fn.dataTable,
        x = 0,
        y = 0,
        j = i.ext.buttons,
        m = function(a, b) {
            "undefined" === typeof b && (b = {});
            !0 === b && (b = {});
            d.isArray(b) && (b = {
                buttons: b
            });
            this.c = d.extend(!0, {}, m.defaults, b);
            b.buttons && (this.c.buttons = b.buttons);
            this.s = {
                dt: new i.Api(a),
                buttons: [],
                listenKeys: "",
                namespace: "dtb" + x++
            };
            this.dom = {
                container: d("<" + this.c.dom.container.tag + "/>").addClass(this.c.dom.container.className)
            };
            this._constructor()
        };
    d.extend(m.prototype, {
        action: function(a, b) {
            var c = this._nodeToButton(a);
            if (b === l) return c.conf.action;
            c.conf.action = b;
            return this
        },
        active: function(a, b) {
            var c = this._nodeToButton(a),
                e = this.c.dom.button.active,
                c = d(c.node);
            if (b === l) return c.hasClass(e);
            c.toggleClass(e, b === l ? !0 :
                b);
            return this
        },
        add: function(a, b) {
            var c = this.s.buttons;
            if ("string" === typeof b) {
                for (var e = b.split("-"), c = this.s, d = 0, g = e.length - 1; d < g; d++) c = c.buttons[1 * e[d]];
                c = c.buttons;
                b = 1 * e[e.length - 1]
            }
            this._expandButton(c, a, !1, b);
            this._draw();
            return this
        },
        container: function() {
            return this.dom.container
        },
        disable: function(a) {
            a = this._nodeToButton(a);
            d(a.node).addClass(this.c.dom.button.disabled);
            return this
        },
        destroy: function() {
            d("body").off("keyup." + this.s.namespace);
            var a = this.s.buttons.slice(),
                b, c;
            b = 0;
            for (c = a.length; b <
                c; b++) this.remove(a[b].node);
            this.dom.container.remove();
            a = this.s.dt.settings()[0];
            b = 0;
            for (c = a.length; b < c; b++)
                if (a.inst === this) {
                    a.splice(b, 1);
                    break
                } return this
        },
        enable: function(a, b) {
            if (!1 === b) return this.disable(a);
            var c = this._nodeToButton(a);
            d(c.node).removeClass(this.c.dom.button.disabled);
            return this
        },
        name: function() {
            return this.c.name
        },
        node: function(a) {
            a = this._nodeToButton(a);
            return d(a.node)
        },
        processing: function(a, b) {
            var c = this._nodeToButton(a);
            if (b === l) return d(c.node).hasClass("processing");
            d(c.node).toggleClass("processing", b);
            return this
        },
        remove: function(a) {
            var b = this._nodeToButton(a),
                c = this._nodeToHost(a),
                e = this.s.dt;
            if (b.buttons.length)
                for (var h = b.buttons.length - 1; 0 <= h; h--) this.remove(b.buttons[h].node);
            b.conf.destroy && b.conf.destroy.call(e.button(a), e, d(a), b.conf);
            this._removeKey(b.conf);
            d(b.node).remove();
            a = d.inArray(b, c);
            c.splice(a, 1);
            return this
        },
        text: function(a, b) {
            var c = this._nodeToButton(a),
                e = this.c.dom.collection.buttonLiner,
                e = c.inCollection && e && e.tag ? e.tag : this.c.dom.buttonLiner.tag,
                h = this.s.dt,
                g = d(c.node),
                f = function(a) {
                    return "function" === typeof a ? a(h, g, c.conf) : a
                };
            if (b === l) return f(c.conf.text);
            c.conf.text = b;
            e ? g.children(e).html(f(b)) : g.html(f(b));
            return this
        },
        _constructor: function() {
            var a = this,
                b = this.s.dt,
                c = b.settings()[0],
                e = this.c.buttons;
            c._buttons || (c._buttons = []);
            c._buttons.push({
                inst: this,
                name: this.c.name
            });
            for (var c = 0, h = e.length; c < h; c++) this.add(e[c]);
            b.on("destroy", function() {
                a.destroy()
            });
            d("body").on("keyup." + this.s.namespace, function(b) {
                if (!n.activeElement || n.activeElement ===
                    n.body) {
                    var c = String.fromCharCode(b.keyCode).toLowerCase();
                    a.s.listenKeys.toLowerCase().indexOf(c) !== -1 && a._keypress(c, b)
                }
            })
        },
        _addKey: function(a) {
            a.key && (this.s.listenKeys += d.isPlainObject(a.key) ? a.key.key : a.key)
        },
        _draw: function(a, b) {
            a || (a = this.dom.container, b = this.s.buttons);
            a.children().detach();
            for (var c = 0, e = b.length; c < e; c++) a.append(b[c].inserter), a.append(" "), b[c].buttons && b[c].buttons.length && this._draw(b[c].collection, b[c].buttons)
        },
        _expandButton: function(a, b, c, e) {
            for (var h = this.s.dt, g = 0,
                    b = !d.isArray(b) ? [b] : b, f = 0, q = b.length; f < q; f++) {
                var k = this._resolveExtends(b[f]);
                if (k)
                    if (d.isArray(k)) this._expandButton(a, k, c, e);
                    else {
                        var p = this._buildButton(k, c);
                        if (p) {
                            e !== l ? (a.splice(e, 0, p), e++) : a.push(p);
                            if (p.conf.buttons) {
                                var u = this.c.dom.collection;
                                p.collection = d("<" + u.tag + "/>").addClass(u.className).attr("role", "menu");
                                p.conf._collection = p.collection;
                                this._expandButton(p.buttons, p.conf.buttons, !0, e)
                            }
                            k.init && k.init.call(h.button(p.node), h, d(p.node), k);
                            g++
                        }
                    }
            }
        },
        _buildButton: function(a, b) {
            var c =
                this.c.dom.button,
                e = this.c.dom.buttonLiner,
                h = this.c.dom.collection,
                g = this.s.dt,
                f = function(b) {
                    return "function" === typeof b ? b(g, k, a) : b
                };
            b && h.button && (c = h.button);
            b && h.buttonLiner && (e = h.buttonLiner);
            if (a.available && !a.available(g, a)) return !1;
            var q = function(a, b, c, e) {
                    e.action.call(b.button(c), a, b, c, e);
                    d(b.table().node()).triggerHandler("buttons-action.dt", [b.button(c), b, c, e])
                },
                k = d("<" + c.tag + "/>").addClass(c.className).attr("tabindex", this.s.dt.settings()[0].iTabIndex).attr("aria-controls", this.s.dt.table().node().id).on("click.dtb",
                    function(b) {
                        b.preventDefault();
                        !k.hasClass(c.disabled) && a.action && q(b, g, k, a);
                        k.blur()
                    }).on("keyup.dtb", function(b) {
                    b.keyCode === 13 && !k.hasClass(c.disabled) && a.action && q(b, g, k, a)
                });
            "a" === c.tag.toLowerCase() && k.attr("href", "#");
            e.tag ? (h = d("<" + e.tag + "/>").html(f(a.text)).addClass(e.className), "a" === e.tag.toLowerCase() && h.attr("href", "#"), k.append(h)) : k.html(f(a.text));
            !1 === a.enabled && k.addClass(c.disabled);
            a.className && k.addClass(a.className);
            a.titleAttr && k.attr("title", f(a.titleAttr));
            a.attr && k.attr(a.attr);
            a.namespace || (a.namespace = ".dt-button-" + y++);
            e = (e = this.c.dom.buttonContainer) && e.tag ? d("<" + e.tag + "/>").addClass(e.className).append(k) : k;
            this._addKey(a);
            return {
                conf: a,
                node: k.get(0),
                inserter: e,
                buttons: [],
                inCollection: b,
                collection: null
            }
        },
        _nodeToButton: function(a, b) {
            b || (b = this.s.buttons);
            for (var c = 0, e = b.length; c < e; c++) {
                if (b[c].node === a) return b[c];
                if (b[c].buttons.length) {
                    var d = this._nodeToButton(a, b[c].buttons);
                    if (d) return d
                }
            }
        },
        _nodeToHost: function(a, b) {
            b || (b = this.s.buttons);
            for (var c = 0, e = b.length; c <
                e; c++) {
                if (b[c].node === a) return b;
                if (b[c].buttons.length) {
                    var d = this._nodeToHost(a, b[c].buttons);
                    if (d) return d
                }
            }
        },
        _keypress: function(a, b) {
            if (!b._buttonsHandled) {
                var c = function(e) {
                    for (var h = 0, g = e.length; h < g; h++) {
                        var f = e[h].conf,
                            q = e[h].node;
                        if (f.key)
                            if (f.key === a) b._buttonsHandled = !0, d(q).click();
                            else if (d.isPlainObject(f.key) && f.key.key === a && (!f.key.shiftKey || b.shiftKey))
                            if (!f.key.altKey || b.altKey)
                                if (!f.key.ctrlKey || b.ctrlKey)
                                    if (!f.key.metaKey || b.metaKey) b._buttonsHandled = !0, d(q).click();
                        e[h].buttons.length &&
                            c(e[h].buttons)
                    }
                };
                c(this.s.buttons)
            }
        },
        _removeKey: function(a) {
            if (a.key) {
                var b = d.isPlainObject(a.key) ? a.key.key : a.key,
                    a = this.s.listenKeys.split(""),
                    b = d.inArray(b, a);
                a.splice(b, 1);
                this.s.listenKeys = a.join("")
            }
        },
        _resolveExtends: function(a) {
            for (var b = this.s.dt, c, e, h = function(c) {
                    for (var e = 0; !d.isPlainObject(c) && !d.isArray(c);) {
                        if (c === l) return;
                        if ("function" === typeof c) {
                            if (c = c(b, a), !c) return !1
                        } else if ("string" === typeof c) {
                            if (!j[c]) throw "Unknown button type: " + c;
                            c = j[c]
                        }
                        e++;
                        if (30 < e) throw "Buttons: Too many iterations";
                    }
                    return d.isArray(c) ? c : d.extend({}, c)
                }, a = h(a); a && a.extend;) {
                if (!j[a.extend]) throw "Cannot extend unknown button type: " + a.extend;
                var g = h(j[a.extend]);
                if (d.isArray(g)) return g;
                if (!g) return !1;
                c = g.className;
                a = d.extend({}, g, a);
                c && a.className !== c && (a.className = c + " " + a.className);
                var f = a.postfixButtons;
                if (f) {
                    a.buttons || (a.buttons = []);
                    c = 0;
                    for (e = f.length; c < e; c++) a.buttons.push(f[c]);
                    a.postfixButtons = null
                }
                if (f = a.prefixButtons) {
                    a.buttons || (a.buttons = []);
                    c = 0;
                    for (e = f.length; c < e; c++) a.buttons.splice(c, 0, f[c]);
                    a.prefixButtons = null
                }
                a.extend = g.extend
            }
            return a
        }
    });
    m.background = function(a, b, c) {
        c === l && (c = 400);
        a ? d("<div/>").addClass(b).css("display", "none").appendTo("body").fadeIn(c) : d("body > div." + b).fadeOut(c, function() {
            d(this).removeClass(b).remove()
        })
    };
    m.instanceSelector = function(a, b) {
        if (!a) return d.map(b, function(a) {
            return a.inst
        });
        var c = [],
            e = d.map(b, function(a) {
                return a.name
            }),
            h = function(a) {
                if (d.isArray(a))
                    for (var f = 0, q = a.length; f < q; f++) h(a[f]);
                else "string" === typeof a ? -1 !== a.indexOf(",") ? h(a.split(",")) :
                    (a = d.inArray(d.trim(a), e), -1 !== a && c.push(b[a].inst)) : "number" === typeof a && c.push(b[a].inst)
            };
        h(a);
        return c
    };
    m.buttonSelector = function(a, b) {
        for (var c = [], e = function(a, b, c) {
                for (var d, f, h = 0, g = b.length; h < g; h++)
                    if (d = b[h]) f = c !== l ? c + h : h + "", a.push({
                        node: d.node,
                        name: d.conf.name,
                        idx: f
                    }), d.buttons && e(a, d.buttons, f + "-")
            }, h = function(a, b) {
                var f, g, i = [];
                e(i, b.s.buttons);
                f = d.map(i, function(a) {
                    return a.node
                });
                if (d.isArray(a) || a instanceof d) {
                    f = 0;
                    for (g = a.length; f < g; f++) h(a[f], b)
                } else if (null === a || a === l || "*" === a) {
                    f = 0;
                    for (g = i.length; f < g; f++) c.push({
                        inst: b,
                        node: i[f].node
                    })
                } else if ("number" === typeof a) c.push({
                    inst: b,
                    node: b.s.buttons[a].node
                });
                else if ("string" === typeof a)
                    if (-1 !== a.indexOf(",")) {
                        i = a.split(",");
                        f = 0;
                        for (g = i.length; f < g; f++) h(d.trim(i[f]), b)
                    } else if (a.match(/^\d+(\-\d+)*$/)) f = d.map(i, function(a) {
                    return a.idx
                }), c.push({
                    inst: b,
                    node: i[d.inArray(a, f)].node
                });
                else if (-1 !== a.indexOf(":name")) {
                    var j = a.replace(":name", "");
                    f = 0;
                    for (g = i.length; f < g; f++) i[f].name === j && c.push({
                        inst: b,
                        node: i[f].node
                    })
                } else d(f).filter(a).each(function() {
                    c.push({
                        inst: b,
                        node: this
                    })
                });
                else "object" === typeof a && a.nodeName && (i = d.inArray(a, f), -1 !== i && c.push({
                    inst: b,
                    node: f[i]
                }))
            }, g = 0, f = a.length; g < f; g++) h(b, a[g]);
        return c
    };
    m.defaults = {
        buttons: ["copy", "excel", "csv", "pdf", "print"],
        name: "main",
        tabIndex: 0,
        dom: {
            container: {
                tag: "div",
                className: "dt-buttons"
            },
            collection: {
                tag: "div",
                className: "dt-button-collection"
            },
            button: {
                tag: "button",
                className: "dt-button",
                active: "active",
                disabled: "disabled"
            },
            buttonLiner: {
                tag: "span",
                className: ""
            }
        }
    };
    m.version = "1.5.1";
    d.extend(j, {
        collection: {
            text: function(a) {
                return a.i18n("buttons.collection",
                    "Collection")
            },
            className: "buttons-collection",
            action: function(a, b, c, e) {
                var h = d(c).parents("div.dt-button-collection"),
                    a = c.position(),
                    g = d(b.table().container()),
                    f = !1,
                    i = c;
                h.length && (f = d(".dt-button-collection").position(), i = h, d("body").trigger("click.dtb-collection"));
                e._collection.addClass(e.collectionLayout).css("display", "none").insertAfter(i).fadeIn(e.fade);
                h = e._collection.css("position");
                f && "absolute" === h ? e._collection.css({
                    top: f.top,
                    left: f.left
                }) : "absolute" === h ? (e._collection.css({
                    top: a.top + c.outerHeight(),
                    left: a.left
                }), f = g.offset().top + g.height(), c = a.top + c.outerHeight() + e._collection.outerHeight() - f, f = a.top - e._collection.outerHeight(), f = g.offset().top - f, c > f && e._collection.css("top", a.top - e._collection.outerHeight() - 5), c = a.left + e._collection.outerWidth(), g = g.offset().left + g.width(), c > g && e._collection.css("left", a.left - (c - g))) : (a = e._collection.height() / 2, a > d(o).height() / 2 && (a = d(o).height() / 2), e._collection.css("marginTop", -1 * a));
                e.background && m.background(!0, e.backgroundClassName, e.fade);
                setTimeout(function() {
                    d("div.dt-button-background").on("click.dtb-collection",
                        function() {});
                    d("body").on("click.dtb-collection", function(a) {
                        var c = d.fn.addBack ? "addBack" : "andSelf";
                        if (!d(a.target).parents()[c]().filter(e._collection).length) {
                            e._collection.fadeOut(e.fade, function() {
                                e._collection.detach()
                            });
                            d("div.dt-button-background").off("click.dtb-collection");
                            m.background(false, e.backgroundClassName, e.fade);
                            d("body").off("click.dtb-collection");
                            b.off("buttons-action.b-internal")
                        }
                    })
                }, 10);
                if (e.autoClose) b.on("buttons-action.b-internal", function() {
                    d("div.dt-button-background").click()
                })
            },
            background: !0,
            collectionLayout: "",
            backgroundClassName: "dt-button-background",
            autoClose: !1,
            fade: 400,
            attr: {
                "aria-haspopup": !0
            }
        },
        copy: function(a, b) {
            if (j.copyHtml5) return "copyHtml5";
            if (j.copyFlash && j.copyFlash.available(a, b)) return "copyFlash"
        },
        csv: function(a, b) {
            if (j.csvHtml5 && j.csvHtml5.available(a, b)) return "csvHtml5";
            if (j.csvFlash && j.csvFlash.available(a, b)) return "csvFlash"
        },
        excel: function(a, b) {
            if (j.excelHtml5 && j.excelHtml5.available(a, b)) return "excelHtml5";
            if (j.excelFlash && j.excelFlash.available(a,
                    b)) return "excelFlash"
        },
        pdf: function(a, b) {
            if (j.pdfHtml5 && j.pdfHtml5.available(a, b)) return "pdfHtml5";
            if (j.pdfFlash && j.pdfFlash.available(a, b)) return "pdfFlash"
        },
        pageLength: function(a) {
            var a = a.settings()[0].aLengthMenu,
                b = d.isArray(a[0]) ? a[0] : a,
                c = d.isArray(a[0]) ? a[1] : a,
                e = function(a) {
                    return a.i18n("buttons.pageLength", {
                        "-1": "Show all rows",
                        _: "Show %d rows"
                    }, a.page.len())
                };
            return {
                extend: "collection",
                text: e,
                className: "buttons-page-length",
                autoClose: !0,
                buttons: d.map(b, function(a, b) {
                    return {
                        text: c[b],
                        className: "button-page-length",
                        action: function(b, c) {
                            c.page.len(a).draw()
                        },
                        init: function(b, c, d) {
                            var e = this,
                                c = function() {
                                    e.active(b.page.len() === a)
                                };
                            b.on("length.dt" + d.namespace, c);
                            c()
                        },
                        destroy: function(a, b, c) {
                            a.off("length.dt" + c.namespace)
                        }
                    }
                }),
                init: function(a, b, c) {
                    var d = this;
                    a.on("length.dt" + c.namespace, function() {
                        d.text(e(a))
                    })
                },
                destroy: function(a, b, c) {
                    a.off("length.dt" + c.namespace)
                }
            }
        }
    });
    i.Api.register("buttons()", function(a, b) {
        b === l && (b = a, a = l);
        this.selector.buttonGroup = a;
        var c = this.iterator(!0, "table", function(c) {
            if (c._buttons) return m.buttonSelector(m.instanceSelector(a,
                c._buttons), b)
        }, !0);
        c._groupSelector = a;
        return c
    });
    i.Api.register("button()", function(a, b) {
        var c = this.buttons(a, b);
        1 < c.length && c.splice(1, c.length);
        return c
    });
    i.Api.registerPlural("buttons().active()", "button().active()", function(a) {
        return a === l ? this.map(function(a) {
            return a.inst.active(a.node)
        }) : this.each(function(b) {
            b.inst.active(b.node, a)
        })
    });
    i.Api.registerPlural("buttons().action()", "button().action()", function(a) {
        return a === l ? this.map(function(a) {
            return a.inst.action(a.node)
        }) : this.each(function(b) {
            b.inst.action(b.node,
                a)
        })
    });
    i.Api.register(["buttons().enable()", "button().enable()"], function(a) {
        return this.each(function(b) {
            b.inst.enable(b.node, a)
        })
    });
    i.Api.register(["buttons().disable()", "button().disable()"], function() {
        return this.each(function(a) {
            a.inst.disable(a.node)
        })
    });
    i.Api.registerPlural("buttons().nodes()", "button().node()", function() {
        var a = d();
        d(this.each(function(b) {
            a = a.add(b.inst.node(b.node))
        }));
        return a
    });
    i.Api.registerPlural("buttons().processing()", "button().processing()", function(a) {
        return a ===
            l ? this.map(function(a) {
                return a.inst.processing(a.node)
            }) : this.each(function(b) {
                b.inst.processing(b.node, a)
            })
    });
    i.Api.registerPlural("buttons().text()", "button().text()", function(a) {
        return a === l ? this.map(function(a) {
            return a.inst.text(a.node)
        }) : this.each(function(b) {
            b.inst.text(b.node, a)
        })
    });
    i.Api.registerPlural("buttons().trigger()", "button().trigger()", function() {
        return this.each(function(a) {
            a.inst.node(a.node).trigger("click")
        })
    });
    i.Api.registerPlural("buttons().containers()", "buttons().container()",
        function() {
            var a = d(),
                b = this._groupSelector;
            this.iterator(!0, "table", function(c) {
                if (c._buttons)
                    for (var c = m.instanceSelector(b, c._buttons), d = 0, h = c.length; d < h; d++) a = a.add(c[d].container())
            });
            return a
        });
    i.Api.register("button().add()", function(a, b) {
        var c = this.context;
        c.length && (c = m.instanceSelector(this._groupSelector, c[0]._buttons), c.length && c[0].add(b, a));
        return this.button(this._groupSelector, a)
    });
    i.Api.register("buttons().destroy()", function() {
        this.pluck("inst").unique().each(function(a) {
            a.destroy()
        });
        return this
    });
    i.Api.registerPlural("buttons().remove()", "buttons().remove()", function() {
        this.each(function(a) {
            a.inst.remove(a.node)
        });
        return this
    });
    var r;
    i.Api.register("buttons.info()", function(a, b, c) {
        var e = this;
        if (!1 === a) return d("#datatables_buttons_info").fadeOut(function() {
            d(this).remove()
        }), clearTimeout(r), r = null, this;
        r && clearTimeout(r);
        d("#datatables_buttons_info").length && d("#datatables_buttons_info").remove();
        d('<div id="datatables_buttons_info" class="dt-button-info"/>').html(a ? "<h2>" + a +
            "</h2>" : "").append(d("<div/>")["string" === typeof b ? "html" : "append"](b)).css("display", "none").appendTo("body").fadeIn();
        c !== l && 0 !== c && (r = setTimeout(function() {
            e.buttons.info(!1)
        }, c));
        return this
    });
    i.Api.register("buttons.exportData()", function(a) {
        if (this.context.length) {
            var b = new i.Api(this.context[0]),
                c = d.extend(!0, {}, {
                    rows: null,
                    columns: "",
                    modifier: {
                        search: "applied",
                        order: "applied"
                    },
                    orthogonal: "display",
                    stripHtml: !0,
                    stripNewlines: !0,
                    decodeEntities: !0,
                    trim: !0,
                    format: {
                        header: function(a) {
                            return e(a)
                        },
                        footer: function(a) {
                            return e(a)
                        },
                        body: function(a) {
                            return e(a)
                        }
                    }
                }, a),
                e = function(a) {
                    if ("string" !== typeof a) return a;
                    a = a.replace(/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi, "");
                    c.stripHtml && (a = a.replace(/<[^>]*>/g, ""));
                    c.trim && (a = a.replace(/^\s+|\s+$/g, ""));
                    c.stripNewlines && (a = a.replace(/\n/g, " "));
                    c.decodeEntities && (v.innerHTML = a, a = v.value);
                    return a
                },
                a = b.columns(c.columns).indexes().map(function(a) {
                    var d = b.column(a).header();
                    return c.format.header(d.innerHTML, a, d)
                }).toArray(),
                h = b.table().footer() ?
                b.columns(c.columns).indexes().map(function(a) {
                    var d = b.column(a).footer();
                    return c.format.footer(d ? d.innerHTML : "", a, d)
                }).toArray() : null,
                g = d.extend({}, c.modifier);
            b.select && "function" === typeof b.select.info && g.selected === l && b.rows(c.rows, d.extend({
                selected: !0
            }, g)).any() && d.extend(g, {
                selected: !0
            });
            for (var g = b.rows(c.rows, g).indexes().toArray(), f = b.cells(g, c.columns), g = f.render(c.orthogonal).toArray(), f = f.nodes().toArray(), j = a.length, k = 0 < j ? g.length / j : 0, m = [k], o = 0, n = 0; n < k; n++) {
                for (var r = [j], s = 0; s < j; s++) r[s] =
                    c.format.body(g[o], n, s, f[o]), o++;
                m[n] = r
            }
            return {
                header: a,
                footer: h,
                body: m
            }
        }
    });
    i.Api.register("buttons.exportInfo()", function(a) {
        a || (a = {});
        var b;
        var c = a;
        b = "*" === c.filename && "*" !== c.title && c.title !== l && null !== c.title && "" !== c.title ? c.title : c.filename;
        "function" === typeof b && (b = b());
        b === l || null === b ? b = null : (-1 !== b.indexOf("*") && (b = d.trim(b.replace("*", d("head > title").text()))), b = b.replace(/[^a-zA-Z0-9_\u00A1-\uFFFF\.,\-_ !\(\)]/g, ""), (c = t(c.extension)) || (c = ""), b += c);
        c = t(a.title);
        c = null === c ? null : -1 !== c.indexOf("*") ?
            c.replace("*", d("head > title").text() || "Exported data") : c;
        return {
            filename: b,
            title: c,
            messageTop: w(this, a.message || a.messageTop, "top"),
            messageBottom: w(this, a.messageBottom, "bottom")
        }
    });
    var t = function(a) {
            return null === a || a === l ? null : "function" === typeof a ? a() : a
        },
        w = function(a, b, c) {
            b = t(b);
            if (null === b) return null;
            a = d("caption", a.table().container()).eq(0);
            return "*" === b ? a.css("caption-side") !== c ? null : a.length ? a.text() : "" : b
        },
        v = d("<textarea/>")[0];
    d.fn.dataTable.Buttons = m;
    d.fn.DataTable.Buttons = m;
    d(n).on("init.dt plugin-init.dt",
        function(a, b) {
            if ("dt" === a.namespace) {
                var c = b.oInit.buttons || i.defaults.buttons;
                c && !b._buttons && (new m(b, c)).container()
            }
        });
    i.ext.feature.push({
        fnInit: function(a) {
            var a = new i.Api(a),
                b = a.init().buttons || i.defaults.buttons;
            return (new m(a, b)).container()
        },
        cFeature: "B"
    });
    return m
});