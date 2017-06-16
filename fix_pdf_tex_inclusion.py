"""Fix the .pdf_tex files produced by inkscape that try to include too many pages.

For a desciption of the bug that makes this necessary, follow this link:
http://tex.stackexchange.com/questions/243499/sharelatex-pdf-inclusion-required-page-does-not-exist-5/268880#268880

Inkscape needs to be in the system path and the Python package PyPDF2 must be installed.

This module exports the folloing functions:
    fix_file    Fix a .pdf_tex file.
    fix_dir     Fix all the .pdf_tex files in a directory.

When executed as a script, the containing directory is fixed.
"""

import re
import os
import PyPDF2

def fix_dir(dir='./', check_svg=True):
    """Fix all the .pdf_tex files in the directory.
    
    If check_svg is True, old and missing .pdf and .pdf_tex files will be newly exported.
    """
    print('fixing the directory', dir)
    dir_content = os.listdir(dir)
    if check_svg:
        for name in dir_content:
            if name.endswith('.svg'):
                basename = name[:-4]
                if (not (basename + '.pdf' in dir_content and basename + '.pdf_tex' in dir_content)
                        or os.path.getmtime(os.path.join(dir, name)) > os.path.getmtime(os.path.join(dir, basename + '.pdf_tex'))):
                    _export_svg_to_pdf_latex(os.path.join(dir, name))
                # elif os.path.getmtime(os.path.join(dir, name)) > os.path.getmtime(os.path.join(dir, basename + '.pdf_tex')):
                    # _export_svg_to_pdf_latex(os.path.join(dir, name))
        dir_content = os.listdir(dir)
    for name in dir_content:
        if name.endswith('.pdf_tex') and name[:-4] in dir_content:
            fix_file(os.path.join(dir, name))

def fix_file(file, numpages=None):
    """Fix the .pdf_tex file.
    
    If numpages is not given, it is determined automatically.
    """
    if not file.endswith('.pdf_tex'):
        file += '.pdf_tex'
    if not numpages:
        numpages = _get_pdf_file_num_pages(file[:-4])
    tempfile = file + '.tmp'
    pageincln = re.compile(r'\s*\\put\(.*\)\{\\includegraphics\[.*,page=(\d+)\]\{.*\}\}%')
    changed = False
    with open(file, 'r') as rf:
        with open(tempfile, 'w') as wf:
            for line in rf:
                critline = pageincln.match(line)
                if critline and int(critline.groups()[0]) > numpages:
                    changed = True
                    continue
                wf.write(line)
    if changed:
        os.remove(file)
        os.rename(tempfile, file)
        print('fixed', file)
    else:
        os.remove(tempfile)
    
def _get_pdf_file_num_pages(f):
    pdf = PyPDF2.PdfFileReader(f)
    return pdf.numPages
    
def _export_svg_to_pdf_latex(f):
    if f.endswith('.svg'):
        f = f[:-4]
    os.system('inkscape -z -C -f{0}.svg -A{0}.pdf --export-latex'.format(f))
    print('exported .pdf and .pdf_tex from', f + '.svg')

def main():
    fix_dir()
    
if __name__ == '__main__':
    main()
    input('done.')
