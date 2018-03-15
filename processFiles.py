import sys
from maya import standalone, cmds
try:
    standalone.initialize()
except:
    pass
import pymel.core as pm
#sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(os.path.dirname(__file__)), '..')))
def createCtlSets():
    ctlSets = pm.ls('*ctlSet', type='objectSet')
    if ctlSets:
        pm.delete(ctlSets)
    ctlGp = pm.ls('ctlGp')
    if ctlGp:
        secGp = [c for c in ctlGp if c.getParent().name().startswith('sec')]
        if secGp:
            secGp = secGp[0]
            ctlAllSet =  pm.sets(name='All_ctlSet',text='gCharacterSet')
            for ctlsGp in secGp.getChildren():
                ctls = [ctl.getParent() for ctl in ctlsGp.listRelatives(type='nurbsCurve',ad=True)]
                ctlsSet = pm.sets(name=ctlsGp.name().split('_')[0]+'_ctlSet',text='gCharacterSet')
                ctlsSet.union(ctls)
                ctlAllSet.union(ctls)

def deleteUnknowPlugin():
    oldplugins = pm.unknownPlugin(q=True, list=True)
    if oldplugins:
        log.info('Found {} unknown plugins'.format(len(oldplugins)))
        for plugin in oldplugins:
            try:
                pm.unknownPlugin(plugin, remove=True)
                log.info('%s removed succesfully'%plugin)
            except:
                log.info('Cannot remove %s'%plugin)
    pm.unloadPlugin('Turtle.mll')

def replaceRef(newRefFiles):
    refs = pm.listReferences()
    for ref in refs:
        print ref
        newRef = [f for f in newRefFiles if f.basename() == ref.path.basename()]
        if newRef:
            ref.replaceWith(newRef[0], f=True)
            print ref, 'replaced with', newRef
        else:
            print "Cannot file newRef in", Files

def hideLoc():
    pm.hide(pm.ls(type='locator'))

def offsim():
    ctls = [c.getParent() for c in pm.ls('*ctl*', type='nurbsCurve')]
    for ctl in ctls:
        for atr in ctl.listAttr(ud=True):
            if 'sim' in atr.lower():
                atr.set(0)

def deleteBaseAnim():
    try:
        pm.delete("*BaseAnimation*")
    except:
        pass

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
            replaceRef(Files)
            createCtlSets()
            hideLoc()
            offsim()
            deleteBaseAnim()
            deleteUnknowPlugin()
            pm.saveFile()
            print "\n|{:_^60}|\n".format('File Save')
