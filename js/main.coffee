---
---

$ ->
    d3.json "links.json", (error, data) ->
        if error?
            console.warn error
            return
        container = d3.select "#container-row"
            .data [data]
        
        panel = container.selectAll ".panel.panel-default"
            .data (d) -> d

        panel
            .enter()
            .append "div"
            .classed "panel", true
            .classed "panel-default", true
            .append "div"
            .classed "panel-heading", true
            .text (d) -> d.classe
                       
        panel.exit().remove()

        table = panel.selectAll "table.table"
            .data (d) -> [d.links]

        table
            .enter()
            .append "table"
            .classed "table", true

        headings =  ["corso", "prof", "titolo", "autore"]
        table.append "thead"
            .append "tr"
            .selectAll "th"
            .data headings
            .enter()
            .append "th"
            .text (d) -> d

        table.append "tbody"

        rows = table.select "tbody"
            .selectAll "tr"
            .data (d) -> d
            .enter()
            .append "tr"
            .on "click", (d) ->
                document.location = d.link
            .on "mouseover", ->
                d3.select this
                    .classed "active", true
            .on "mouseout", ->
                d3.select this
                    .classed "active", false

        rows.append "td"
            .text (d) -> d.corso
        rows.append "td"
            .text (d) -> d.prof
        rows.append "td"
            .append "a"
                .attr "href", (d) -> d.link
                .html (d) -> d.titolo
        rows.append "td"
            .text (d) -> d.autore

        table.exit().remove()
