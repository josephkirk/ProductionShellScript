import sys
from maya import standalone, cmds
try:
    standalone.initialize()
except:
    pass
import pymel.core as pm
#sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.dirname(__file__)), '..')))

def deleteBaseAnim():
    try:
        pm.delete("*BaseAnimation*")
    except:
        pass

def deleteUnknowPlugin():
    oldplugins = pm.unknownPlugin(q=True, list=True)
    if oldplugins:
        for plugin in oldplugins:
            print plugin 
            try:
                pm.unknownPlugin(plugin, remove=True)
                print '%s removed succesfully'%plugin            
            except:
                print 'Cannot remove %s'%plugin
    try:
        pm.delete("*BaseAnimation*")
    except:
        pass
    pm.unloadPlugin('Turtle')

if sys.argv[1:]:
    args = sys.argv[1:]
    for arg in args:
        filePath = pm.util.path(arg).abspath()
        if filePath.isfile():
            print "open", filePath
            # cmds.file(filePath.abspath(), open=True, f=True)
            pm.openFile(filePath, f=True)
            deleteUnknowPlugin()
            deleteBaseAnim()
            pm.saveFile()
            print "\n|{:_^60}|\n".format('File Save')
