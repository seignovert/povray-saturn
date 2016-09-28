#!/bin/python
# -*- coding: utf-8 -*-
# @brief    Extract the radius and the opacity of Saturn rings
# @date     2016/09/28
# @author   B.Seignovert (univ-reims@seignovert.fr)
# @version  1.0
#----------------------------------------------------

import numpy             as np
import matplotlib.pyplot as plt

from PIL                   import Image
from scipy.ndimage.filters import gaussian_filter

def Rings(filename,xmin,xmax,nbins=20.):
  img = Image.open("%s.jpg" % filename)
  
  r,_,_ = img.split()
  red = np.array( r.im )
  
  x = np.linspace(xmin,xmax,len(red))
  
  gauss = gaussian_filter(red/255.,sigma=7)
  dig   = np.digitize(gauss, np.linspace(0,1,nbins)) / nbins
  
  plt.figure()
  plt.xlim(xmin,xmax)
  plt.ylim(0,1)
  
  plt.plot(x,dig)
  plt.savefig("%s.pdf" % filename)
  
  r_min = []; r_max = []; r_opa = []
  
  r = xmin ; d = dig[0]
  
  for ii in range(len(x)):
    if dig[ii] != d:
      r_min.append( r )
      r_max.append( x[ii] )
      r_opa.append( d )
      r = x[ii]
      d = dig[ii]
  
  np.savetxt('../src/%s.dat' % filename, np.transpose([r_min,r_max,1.-np.array(r_opa)]), fmt='ring(%i,%i,%.2f)' )
  return

Rings('C_Ring',74500,92000)
Rings('B_Ring',92000,117580)
Rings('C_Div',117580,122200)
Rings('A_Ring',122200,136780)