# Liste des plugins QGIS

<div style="display: flex; gap: 2rem; align-items: flex-start;">

  <!-- Table des matières flottante -->
  <div id="toc" style="flex: 0 0 250px; position: sticky; top: 20px; max-height: 90vh; overflow-y: auto; border:1px solid #ddd; padding: 1rem; border-radius:8px; background:#f9f9f9;">
  </div>

  <!-- Conteneur des cartes -->
  <div id="plugins" style="flex: 1; display: grid; grid-template-columns: repeat(auto-fill,minmax(300px,1fr)); gap: 1rem;"></div>

</div>

<script>
fetch("https://qgis-depot.mercantour.eu/plugins.xml")
  .then(resp => resp.text())
  .then(str => (new window.DOMParser()).parseFromString(str, "text/xml"))
  .then(xml => {
    let plugins = Array.from(xml.getElementsByTagName("pyqgis_plugin"));
    let container = document.getElementById("plugins");
    let toc = document.getElementById("toc");

    // Trier les plugins par nom
    plugins.sort((a, b) => {
      let nameA = a.getAttribute("name")?.toLowerCase() || "";
      let nameB = b.getAttribute("name")?.toLowerCase() || "";
      return nameA.localeCompare(nameB);
    });

    let tocHtml = "<h2 style='margin-top:0; font-size:0.8rem;'>Table alphabétique</h2>";
    tocHtml += "<ul style='padding-left:1rem; font-size:0.7rem; line-height:0.8;'>";

    plugins.forEach((plugin, idx) => {
      let name = plugin.getAttribute("name") || "Sans nom";
      let version = plugin.getAttribute("version") || "N/A";
      let description = plugin.getElementsByTagName("description")[0]?.textContent || "";
      let homepage = plugin.getElementsByTagName("homepage")[0]?.textContent || "";
      let repository = plugin.getElementsByTagName("repository")[0]?.textContent || "";
      let tracker = plugin.getElementsByTagName("tracker")[0]?.textContent || "";

      // Id unique pour l'ancre
      let anchorId = "plugin-" + idx;
      tocHtml += `<li style="margin-bottom:0.3rem;"><a href="#${anchorId}">${name}</a></li>`;

      let card = document.createElement("div");
      card.id = anchorId;
      card.style.border = "1px solid #ddd";
      card.style.borderRadius = "8px";
      card.style.padding = "15px";
      card.style.boxShadow = "0 2px 4px rgba(0,0,0,0.1)";
      card.style.background = "#fff";

      card.innerHTML = `
        <h3 style="margin-top:0">${name} <small style="color:#666">v${version}</small></h3>
        <p>${description}</p>
        <ul style="padding-left:18px; margin:0">
          ${homepage ? `<li><a href="${homepage}" target="_blank">Documentation</a></li>` : ""}
          ${repository ? `<li><a href="${repository}" target="_blank">Code Source</a></li>` : ""}
          ${tracker ? `<li><a href="${tracker}" target="_blank">Rapporter un problème</a></li>` : ""}
        </ul>
      `;

      container.appendChild(card);
    });

    tocHtml += "</ul>";
    toc.innerHTML = tocHtml;
  })
  .catch(err => {
    document.getElementById("plugins").innerHTML = "<p style='color:red'>Impossible de charger la liste des plugins.</p>";
    console.error(err);
  });
</script>
