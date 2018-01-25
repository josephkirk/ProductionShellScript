from maya import standalone, cmds
try:
    standalone.initialize()
except:
    pass
import sys
import pymel.core as pm
if sys.argv[1:]:
    searchPath = sys.argv[1]
    args = sys.argv[2:]
    if not pm.util.path(searchPath).isdir():
        print("search file path %s is not valid"%searchPath)
        quit()
    Files = list(pm.util.path(searchPath).walkfiles())
    for arg in args:
        filePath = pm.util.path(arg).abspath()
        if filePath.isfile():
            print "open", filePath
            # cmds.file(filePath.abspath(), open=True, f=True)
            pm.openFile(filePath, f=True)
            refs = pm.listReferences()
            for ref in refs:
                print ref
                newRef = [f for f in Files if f.basename() == ref.path.basename()]
                if newRef:
                    ref.replaceWith(newRef[0], f=True)
                    print ref, 'replaced with', newRef
                else:
                    print "Cannot file newRef in", Files
            pm.saveFile()