---
title: Liste des plugins QGIS
hide:
  - path
  - toc
  - navigation
---

<div class="pnm-hero" markdown>

<div class="pnm-hero__brand" markdown>

:material-puzzle-plus:{ .pnm-hero__icon }

</div>

<div class="pnm-hero__text" markdown>

# Les plugins QGIS du Parc

Cette page présente les **plugins QGIS développés ou hébergés par le Parc**, disponibles depuis le dépôt de plugins du Parc. Chaque plugin renvoie vers sa documentation, son code source et un lien pour signaler un problème.

[:material-download: Installer un plugin QGIS](../tutos/installation_plugin_via_depot.md){ .md-button .md-button--primary }


</div>

</div>

!!! success "Une liste toujours à jour"
    Cette liste est **générée automatiquement** à partir du dépôt de plugins du Parc : elle affiche toujours les plugins et les versions actuellement disponibles.

## :material-puzzle: Plugins disponibles

<p>
  <input id="plugin-filter" type="search" placeholder="Filtrer les plugins par nom ou description..."
         aria-label="Filtrer les plugins"
         style="width:100%; padding:.5rem .8rem; border:1px solid var(--md-default-fg-color--lighter); border-radius:.4rem; background:var(--md-default-bg-color); color:var(--md-default-fg-color);">
</p>

<p id="plugin-count" style="margin-top:0; font-size:.8rem; color:var(--md-default-fg-color--light);"></p>

<div class="grid cards" id="plugins">
  <ul id="plugins-list"></ul>
</div>

<div id="plugins-error"></div>

<script>
(function () {
  var list = document.getElementById("plugins-list");
  var countEl = document.getElementById("plugin-count");
  var filterEl = document.getElementById("plugin-filter");
  var errorEl = document.getElementById("plugins-error");

  function text(xmlParent, tag) {
    var el = xmlParent.getElementsByTagName(tag)[0];
    return el && el.textContent ? el.textContent.trim() : "";
  }

  function addLink(ul, href, label) {
    if (!href) { return; }
    var li = document.createElement("li");
    var a = document.createElement("a");
    a.href = href;
    a.target = "_blank";
    a.rel = "noopener";
    a.textContent = label;
    li.appendChild(a);
    ul.appendChild(li);
  }

  function updateCount() {
    var all = list.children.length;
    var shown = Array.prototype.filter.call(list.children, function (li) {
      return !li.hidden;
    }).length;
    countEl.textContent = shown === all
      ? all + " plugin" + (all > 1 ? "s" : "") + " disponible" + (all > 1 ? "s" : "")
      : shown + " plugin" + (shown > 1 ? "s" : "") + " sur " + all;
  }

  fetch("https://qgis-depot.mercantour.eu/plugins.xml")
    .then(function (resp) {
      if (!resp.ok) { throw new Error("HTTP " + resp.status); }
      return resp.text();
    })
    .then(function (str) {
      return new window.DOMParser().parseFromString(str, "text/xml");
    })
    .then(function (xml) {
      var plugins = Array.prototype.slice.call(xml.getElementsByTagName("pyqgis_plugin"));

      plugins.sort(function (a, b) {
        return (a.getAttribute("name") || "").toLowerCase()
          .localeCompare((b.getAttribute("name") || "").toLowerCase());
      });

      plugins.forEach(function (plugin) {
        var name = plugin.getAttribute("name") || "Sans nom";
        var version = plugin.getAttribute("version") || "";
        var description = text(plugin, "description");

        var li = document.createElement("li");
        li.dataset.search = (name + " " + description).toLowerCase();

        var title = document.createElement("p");
        var strong = document.createElement("strong");
        strong.textContent = name;
        title.appendChild(strong);
        if (version) {
          var small = document.createElement("small");
          small.textContent = " v" + version;
          title.appendChild(small);
        }
        li.appendChild(title);

        li.appendChild(document.createElement("hr"));

        var desc = document.createElement("p");
        desc.textContent = description;
        li.appendChild(desc);

        var links = document.createElement("ul");
        addLink(links, text(plugin, "homepage"), "Documentation");
        addLink(links, text(plugin, "repository"), "Code source");
        addLink(links, text(plugin, "tracker"), "Signaler un problème");
        if (links.children.length) { li.appendChild(links); }

        list.appendChild(li);
      });

      updateCount();

      filterEl.addEventListener("input", function () {
        var q = filterEl.value.trim().toLowerCase();
        Array.prototype.forEach.call(list.children, function (li) {
          li.hidden = q !== "" && li.dataset.search.indexOf(q) === -1;
        });
        updateCount();
      });
    })
    .catch(function (err) {
      errorEl.innerHTML =
        '<div class="admonition failure"><p class="admonition-title">Liste indisponible</p>' +
        "<p>Impossible de charger la liste des plugins pour le moment. " +
        "Vérifiez votre connexion au réseau du Parc, ou contactez le SI : " +
        "<code>si@mercantour-parcnational.fr</code>.</p></div>";
      console.error(err);
    });
})();
</script>