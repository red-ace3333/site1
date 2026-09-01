(()=>{window.throttle=function(s,d){let c,i;return function(...l){let m=this;!i||Date.now()-i>=d?(s.apply(m,l),i=Date.now()):(clearTimeout(c),c=setTimeout(()=>{s.apply(m,l),i=Date.now()},d-(Date.now()-i)))}};(function(){[Element,Document,Window].forEach(e=>{e.prototype._addEventListener=e.prototype.addEventListener,e.prototype._removeEventListener=e.prototype.removeEventListener,e.prototype.addEventListener=e.prototype.on=function(r,t,o){this.__listeners__=this.__listeners__||{},this.__listeners__[r]=this.__listeners__[r]||[];for(let[n,a]of this.__listeners__[r])if(n===t&&JSON.stringify(a)===JSON.stringify(o))return this;return this.__listeners__[r].push([t,o]),this._addEventListener(r,t,o),this},e.prototype.removeEventListener=e.prototype.off=function(r,t,o){return!this.__listeners__||!this.__listeners__[r]?this:t?(this._removeEventListener(r,t,o),this.__listeners__[r]=this.__listeners__[r].filter(([n,a])=>n!==t||JSON.stringify(a)!==JSON.stringify(o)),this.__listeners__[r].length===0&&delete this.__listeners__[r],this):(this.__listeners__[r].forEach(([n,a])=>{this.removeEventListener(r,n,a)}),delete this.__listeners__[r],this)}}),window._$=e=>document.querySelector(e),window._$$=e=>document.querySelectorAll(e);let s=document.createElement("a");s.className="nav-icon dark-mode-btn",_$("#sub-nav").append(s);let d=window.matchMedia("(prefers-color-scheme: dark)").matches;function c(e){let t=e==="true"||e==="auto"&&d;document.documentElement.setAttribute("data-theme",t?"dark":null),localStorage.setItem("dark_mode",e),s.id=`nav-${e==="true"?"moon":e==="false"?"sun":"circle-half-stroke"}-btn`,document.body.dispatchEvent(new CustomEvent(`${t?"dark":"light"}-theme-set`))}let i=localStorage.getItem("dark_mode")||document.documentElement.getAttribute("data-theme-mode")||"auto";c(i),s.addEventListener("click",throttle(()=>{let e=["auto","false","true"],r=e[(e.indexOf(localStorage.getItem("dark_mode"))+1)%3];c(r)},1e3));let l=0;if(document.addEventListener("scroll",()=>{let e=document.documentElement.scrollTop||document.body.scrollTop,r=e-l;window.diffY=r,l=e,r<0?_$("#header-nav")?.classList.remove("header-nav-hidden"):_$("#header-nav")?.classList.add("header-nav-hidden")}),window.Pace&&Pace.on("done",()=>{Pace.sources[0].elements=[]}),window.materialTheme){let r=function(){if(_$("#reimu-generated-theme-style"))return;let n=`
    :root {
      --red-0: var(--md-sys-color-primary-light);
      --red-1: color-mix(in srgb, var(--md-sys-color-primary-light) 90%, white);
      --red-2: color-mix(in srgb, var(--md-sys-color-primary-light) 75%, white);
      --red-3: color-mix(in srgb, var(--md-sys-color-primary-light) 55%, white);
      --red-4: color-mix(in srgb, var(--md-sys-color-primary-light) 40%, white);
      --red-5: color-mix(in srgb, var(--md-sys-color-primary-light) 15%, white);
      --red-5-5: color-mix(in srgb, var(--md-sys-color-primary-light) 10%, white);
      --red-6: color-mix(in srgb, var(--md-sys-color-primary-light) 5%, white);
    
      --color-border: var(--red-3);
      --color-link: var(--red-1);
      --color-meta-shadow: var(--red-6);
      --color-h2-after: var(--red-1);
      --color-red-6-shadow: var(--red-2);
      --color-red-3-shadow: var(--red-3);
    }
    
    [data-theme="dark"]:root {
      --red-0: var(--red-1);
      --red-1: color-mix(in srgb, var(--md-sys-color-primary-dark) 90%, white);
      --red-2: color-mix(in srgb, var(--md-sys-color-primary-dark) 80%, white);
      --red-3: color-mix(in srgb, var(--md-sys-color-primary-dark) 75%, white);
      --red-4: color-mix(in srgb, var(--md-sys-color-primary-dark) 30%, transparent);
      --red-5: color-mix(in srgb, var(--md-sys-color-primary-dark) 20%, transparent);
      --red-5-5: color-mix(in srgb, var(--md-sys-color-primary-dark) 10%, transparent);
      --red-6: color-mix(in srgb, var(--md-sys-color-primary-dark) 5%, transparent);
      
      --color-border: var(--red-5);
    }
    `,a=document.createElement("style");a.id="reimu-generated-theme-style",a.textContent=n,document.body.appendChild(a)};var m=r;let e=new materialTheme.ColorThemeExtractor({needTransition:!1});async function t(o){let n=await e.generateThemeSchemeFromImage(o);document.documentElement.style.setProperty("--md-sys-color-primary-light",e.hexFromArgb(n.schemes.light.props.primary)),document.documentElement.style.setProperty("--md-sys-color-primary-dark",e.hexFromArgb(n.schemes.dark.props.primary)),r()}window.generateSchemeHandler=()=>{if(window.bannerElement?.src)window.bannerElement.complete?t(bannerElement):window.bannerElement.addEventListener("load",()=>{t(bannerElement)},{once:!0});else if(window.bannerElement?.style.background){let o=window.bannerElement.style.background.match(/\d+/g);if(!o||o.length<3)return;let n=e.generateThemeScheme({r:parseInt(o[0]),g:parseInt(o[1]),b:parseInt(o[2])});document.documentElement.style.setProperty("--md-sys-color-primary-light",e.hexFromArgb(n.schemes.light.props.primary)),document.documentElement.style.setProperty("--md-sys-color-primary-dark",e.hexFromArgb(n.schemes.dark.props.primary)),r()}}}})();window.safeImport=async(s,d)=>{if(!d)return import(s);let i=await(await fetch(s)).text(),l=await crypto.subtle.digest("SHA-384",new TextEncoder().encode(i));if("sha384-"+btoa(String.fromCharCode(...new Uint8Array(l)))!==d)throw new Error(`Integrity check failed for ${s}`);let e=new Blob([i],{type:"application/javascript"}),r=URL.createObjectURL(e),t=await import(r);return URL.revokeObjectURL(r),t};})();
