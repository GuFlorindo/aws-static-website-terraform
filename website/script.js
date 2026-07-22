(function () {
  "use strict";
 
  var reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
 
  /* --------------------------------------------------------
     Menu mobile
  -------------------------------------------------------- */
  var navToggle = document.getElementById("navToggle");
  var primaryNav = document.getElementById("primaryNav");
 
  if (navToggle && primaryNav) {
    navToggle.addEventListener("click", function () {
      var isOpen = primaryNav.classList.toggle("is-open");
      navToggle.setAttribute("aria-expanded", String(isOpen));
    });
 
    primaryNav.querySelectorAll("a").forEach(function (link) {
      link.addEventListener("click", function () {
        primaryNav.classList.remove("is-open");
        navToggle.setAttribute("aria-expanded", "false");
      });
    });
  }
 
  /* --------------------------------------------------------
     Marca o link de navegação ativo conforme a seção visível
  -------------------------------------------------------- */
  var navLinks = document.querySelectorAll("[data-nav]");
  var sections = Array.prototype.slice
    .call(navLinks)
    .map(function (link) {
      var id = link.getAttribute("href");
      return id && id.charAt(0) === "#" ? document.querySelector(id) : null;
    })
    .filter(Boolean);
 
  if ("IntersectionObserver" in window && sections.length) {
    var navObserver = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          var link = document.querySelector('[data-nav][href="#' + entry.target.id + '"]');
          if (!link) return;
          if (entry.isIntersecting) {
            navLinks.forEach(function (l) { l.classList.remove("is-active"); });
            link.classList.add("is-active");
          }
        });
      },
      { rootMargin: "-45% 0px -45% 0px" }
    );
    sections.forEach(function (section) { navObserver.observe(section); });
  }
 
  /* --------------------------------------------------------
     Revela seções ao rolar a página
  -------------------------------------------------------- */
  var revealTargets = document.querySelectorAll(
    ".about-grid, .timeline, .edu-grid, .skills-grid, .cert-grid, .project-grid, .project-links, .section-title, .section-lead"
  );
  revealTargets.forEach(function (el) { el.classList.add("reveal"); });
 
  if ("IntersectionObserver" in window) {
    var revealObserver = new IntersectionObserver(
      function (entries, obs) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add("is-visible");
            obs.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.15 }
    );
    revealTargets.forEach(function (el) { revealObserver.observe(el); });
  } else {
    revealTargets.forEach(function (el) { el.classList.add("is-visible"); });
  }

  /* --------------------------------------------------------
     Botão "copiar" do bloco de código Terraform
  -------------------------------------------------------- */
  var copyBtn = document.querySelector(".copy-btn");
  if (copyBtn) {
    copyBtn.addEventListener("click", function () {
      var targetId = copyBtn.getAttribute("data-copy-target");
      var codeEl = document.getElementById(targetId);
      if (!codeEl) return;
 
      var text = codeEl.innerText;
      var done = function () {
        var original = copyBtn.textContent;
        copyBtn.textContent = "Copiado";
        copyBtn.classList.add("is-copied");
        setTimeout(function () {
          copyBtn.textContent = original;
          copyBtn.classList.remove("is-copied");
        }, 1800);
      };
 
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(done).catch(function () {
          fallbackCopy(text, done);
        });
      } else {
        fallbackCopy(text, done);
      }
    });
  }
 
  function fallbackCopy(text, onDone) {
    var textarea = document.createElement("textarea");
    textarea.value = text;
    textarea.style.position = "fixed";
    textarea.style.opacity = "0";
    document.body.appendChild(textarea);
    textarea.select();
    try { document.execCommand("copy"); } catch (e) { /* silencioso */ }
    document.body.removeChild(textarea);
    onDone();
  }
  /* --------------------------------------------------------
     Ano no rodapé
  -------------------------------------------------------- */
  var yearEl = document.getElementById("year");
  if (yearEl) yearEl.textContent = String(new Date().getFullYear());
 
})();
