import os, glob

tdir = r'c:\Users\noman\Downloads\NEW\Landing Page Portfolio\templates'

files = glob.glob(os.path.join(tdir, '*.html'))
updated = 0
for fp in files:
    txt = open(fp, encoding='utf-8').read()
    if "(ch / s) + 'px'" in txt:
        # Replace the old height line with the new scrollable approach
        txt = txt.replace(
            "f.style.height = (ch / s) + 'px';",
            "f.style.height = '900px';"
        )
        # Remove the ch variable usage - replace 'cw = w.offsetWidth, ch = w.offsetHeight' with just cw
        txt = txt.replace(
            "const cw = w.offsetWidth, ch = w.offsetHeight;",
            "const cw = w.offsetWidth;"
        )
        open(fp, 'w', encoding='utf-8').write(txt)
        updated += 1
        print('Updated:', os.path.basename(fp))

print(f'\nDone: {updated} files updated')
