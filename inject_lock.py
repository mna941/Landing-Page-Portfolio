import os, glob

tdir = r'c:\Users\noman\Downloads\NEW\Landing Page Portfolio\templates'

# HTML to inject: Lock button and SVG icons
BTN_HTML = '''        </div>
        <button id="previewLockBtn" class="preview-lock-btn" title="Unlock preview to scroll">
            <!-- Locked Icon (Default) -->
            <svg id="icon-locked" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
            </svg>
            <!-- Unlocked Icon (Hidden initially) -->
            <svg id="icon-unlocked" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                <path d="M7 11V7a5 5 0 0 1 9.9-1"></path>
            </svg>
        </button>
        <div class="detail-hero-overlay"></div>'''

# JS to inject for the toggle functionality
JS_HTML = '''
        const lockBtn = document.getElementById('previewLockBtn');
        const heroIframe = document.getElementById('heroIframe');
        const iconLocked = document.getElementById('icon-locked');
        const iconUnlocked = document.getElementById('icon-unlocked');
        
        let isUnlocked = false;
        
        // Initial state: locked
        heroIframe.style.pointerEvents = 'none';

        if(lockBtn) {
            lockBtn.addEventListener('click', () => {
                isUnlocked = !isUnlocked;
                if (isUnlocked) {
                    lockBtn.classList.add('unlocked');
                    iconLocked.style.display = 'none';
                    iconUnlocked.style.display = 'block';
                    heroIframe.style.pointerEvents = 'auto'; // allow interaction/scroll
                    lockBtn.setAttribute('title', 'Lock preview to disable scroll');
                } else {
                    lockBtn.classList.remove('unlocked');
                    iconLocked.style.display = 'block';
                    iconUnlocked.style.display = 'none';
                    heroIframe.style.pointerEvents = 'none'; // block interaction/scroll
                    lockBtn.setAttribute('title', 'Unlock preview to scroll');
                }
            });
        }
        
        window.addEventListener('resize', scaleHero);'''

files = glob.glob(os.path.join(tdir, '*.html'))
updated = 0
for fp in files:
    txt = open(fp, encoding='utf-8').read()
    
    # 1. Inject Button
    if '<button id="previewLockBtn"' not in txt:
        old_div_end = '        </div>\n        <div class="detail-hero-overlay"></div>'
        if old_div_end in txt:
            txt = txt.replace(old_div_end, BTN_HTML)
        else:
            # fallback for formatting differences
            txt = txt.replace('</div>\n        <div class="detail-hero-overlay"></div>', BTN_HTML)

    # 2. Inject JS logic
    if 'const lockBtn =' not in txt:
        old_js = '        window.addEventListener(\'resize\', scaleHero);'
        txt = txt.replace(old_js, JS_HTML)
        
    open(fp, 'w', encoding='utf-8').write(txt)
    updated += 1
    print('Updated:', os.path.basename(fp))

print(f'\nDone: {updated} files updated')
