import pymel.core as pm
ctlGp = pm.ls('ctlGp')
if ctlGp:
    secGp = [c for c in ctlGp if c.getParent().name().startswith('sec')]
    if secGp:
        secGp = secGp[0]
        for ctlsGp in secGp.getChildren():
            print ctlsGp
            ctls = ctlsGp.listRelatives(type='nurbsCurve',ad=True)
            ctlsSet = pm.sets(name=ctlsGp.name().split('_')[0]+'_ctlSet',text='gCharacterSet')
            ctlsSet.union(ctls)
            print ctlsSet