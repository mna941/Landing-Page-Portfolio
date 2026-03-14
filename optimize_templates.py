import os, glob

tdir = r'c:\Users\noman\Downloads\NEW\Landing Page Portfolio\templates'

# New optimized script block
OPTIMIZED_JS = '''
        const navbar = document.getElementById('navbar');
        const backToTopBtn = document.getElementById('backToTop');
        
        // Performance: Use throttle for scroll events
        let isScrolling = false;
        window.addEventListener('scroll', () => {
            if (!isScrolling) {
                window.requestAnimationFrame(() => {
                    navbar.classList.toggle('scrolled', window.scrollY > 50);
                    backToTopBtn.classList.toggle('visible', window.scrollY > 500);
                    isScrolling = false;
                });
                isScrolling = true;
            }
        });

        // Performance: Use Intersection Observer for reveal animations
        const revealObserver = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                    revealObserver.unobserve(entry.target);
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('[data-reveal]').forEach(el => revealObserver.observe(el));

        function scaleHero() {
            const w = document.getElementById('heroWrapper');
            const f = document.getElementById('heroIframe');
            if (!w || !f) return;
            const cw = w.offsetWidth;
            if (!cw) return;
            const s = cw / 1440;
            f.style.width = '1440px';
            f.style.height = '900px';
            f.style.transform = 'scale(' + s + ')';
            // Set wrapper height to match scaled iframe so scrolling works
            if(w.parentElement.classList.contains('detail-hero')) {
                 w.style.height = (900 * s) + 'px';
            }
        }

        const lockBtn = document.getElementById('previewLockBtn');
        const heroIframe = document.getElementById('heroIframe');
        const iconLocked = document.getElementById('icon-locked');
        const iconUnlocked = document.getElementById('icon-unlocked');
        
        let isUnlocked = false;
        
        // Initial state: locked
        if (heroIframe) heroIframe.style.pointerEvents = 'none';

        if(lockBtn) {
            lockBtn.addEventListener('click', () => {
                isUnlocked = !isUnlocked;
                lockBtn.classList.toggle('unlocked', isUnlocked);
                iconLocked.style.display = isUnlocked ? 'none' : 'block';
                iconUnlocked.style.display = isUnlocked ? 'block' : 'none';
                heroIframe.style.pointerEvents = isUnlocked ? 'auto' : 'none';
                lockBtn.setAttribute('title', isUnlocked ? 'Lock preview to disable scroll' : 'Unlock preview to scroll');
                
                // Visual feedback
                lockBtn.style.transform = 'scale(0.9)';
                setTimeout(() => { lockBtn.style.transform = ''; }, 100);
            });
        }
        
        // Performance: Debounce resize event
        let resizeTimer;
        window.addEventListener('resize', () => {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(scaleHero, 150);
        });
        
        scaleHero();
'''

files = glob.glob(os.path.join(tdir, '*.html'))
updated = 0
for fp in files:
    with open(fp, 'r', encoding='utf-8') as f:
        txt = f.read()
    
    # Locate the script tag content
    import re
    # Match everything between <script> and </script> but keeping the external scripts if any (though there are none)
    # We want to replace the block we previously injected and the base logic
    # The previous injection ended with scaleHero(); revealOnScroll();
    
    pattern = r'<script>(.*?)</script>'
    new_txt = re.sub(pattern, f'<script>{OPTIMIZED_JS}</script>', txt, flags=re.DOTALL)
    
    if new_txt != txt:
        with open(fp, 'w', encoding='utf-8') as f:
            f.write(new_txt)
        updated += 1
        print('Optimized:', os.path.basename(fp))

print(f'\nDone: {updated} files optimized')
