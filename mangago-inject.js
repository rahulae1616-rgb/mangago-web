// MANGA GO Custom Script Injection
(function() {
    console.log("MANGA GO UI/UX Customization loaded successfully.");

    // Recursive function to replace text in nodes
    function replaceTextInNode(node) {
        if (!node) return;
        
        // Skip script, style, and iframe tags
        const skipTags = ['SCRIPT', 'STYLE', 'IFRAME'];
        if (skipTags.includes(node.nodeName)) return;

        if (node.nodeType === Node.TEXT_NODE) {
            let text = node.nodeValue;
            let newText = text.replace(/Suwayomi/g, 'MANGA GO').replace(/Tachidesk/g, 'MANGA GO');
            if (newText !== text) {
                node.nodeValue = newText;
            }
        } else {
            for (let child of node.childNodes) {
                replaceTextInNode(child);
            }
        }
    }

    // Apply customizations dynamically
    function applyCustomizations() {
        // 1. Force Tab Title
        if (document.title.includes("Suwayomi") || document.title.includes("Tachidesk")) {
            document.title = "MANGA GO";
        }

        // 2. Translate text nodes to MANGA GO
        replaceTextInNode(document.body);

        // 3. Replace default logos with custom MANGA GO logo
        const logoImgs = document.querySelectorAll('img[src*="logo"], img[src*="favicon"], link[rel*="icon"]');
        logoImgs.forEach(img => {
            if (img.tagName === 'LINK') {
                img.href = "/mangago-logo.png";
            } else if (img.src && !img.src.includes("mangago-logo.png")) {
                img.src = "/mangago-logo.png";
            }
        });

        // 4. Custom About Tab layout
        const githubLinks = document.querySelectorAll('a[href*="github.com/Suwayomi"], a[href*="github.com/tachidesk"], a[href*="discord.gg"]');
        if (githubLinks.length > 0) {
            githubLinks.forEach(link => {
                const parent = link.parentElement;
                if (parent) {
                    // Hide the original links
                    link.style.display = "none";
                    
                    // Inject Developed by RAHUL CHANDRA card if not already done
                    const aboutSection = parent.closest('.MuiPaper-root') || parent;
                    if (aboutSection && !aboutSection.querySelector('.developer-card')) {
                        const creditsDiv = document.createElement('div');
                        creditsDiv.className = 'developer-card';
                        creditsDiv.style.textAlign = 'center';
                        creditsDiv.style.margin = '25px auto';
                        creditsDiv.style.padding = '15px';
                        creditsDiv.style.borderRadius = '10px';
                        creditsDiv.style.background = 'rgba(255, 255, 255, 0.05)';
                        creditsDiv.style.border = '1px solid rgba(255, 255, 255, 0.1)';
                        creditsDiv.style.maxWidth = '300px';
                        
                        creditsDiv.innerHTML = `
                            <span style="font-size: 0.9em; opacity: 0.8; display: block; letter-spacing: 1px; color: var(--text-color);">Developed by</span>
                            <span class="developer-name">RAHUL CHANDRA</span>
                        `;
                        
                        // Insert at the bottom of the section
                        aboutSection.appendChild(creditsDiv);
                    }
                }
            });
        }
    }

    // Set up a MutationObserver to apply customizations instantly when the page changes
    const observer = new MutationObserver((mutations) => {
        applyCustomizations();
    });

    // Run immediately when loaded and continuously observe the document
    if (document.body) {
        applyCustomizations();
        observer.observe(document.body, { childList: true, subtree: true });
    } else {
        document.addEventListener('DOMContentLoaded', () => {
            applyCustomizations();
            observer.observe(document.body, { childList: true, subtree: true });
        });
    }

    // Secondary timer backup to ensure title and DOM changes remain updated
    setInterval(applyCustomizations, 500);
})();
