import numpy as np
"""
A collection of tools for tracking or reconstructing the motion of a translation stage used in touch stimulation experiments.

"""



__all__ = ['stageIter', 'parse1dMotion', 'recover3d', 'parseStageTriggers', 'findMotionEpochs']


"""
Reconstructs the path of the stage, assuming that it moves stepSize microns by 'col' times to the right, then moves down, then moves
col times to the left, stopping when the stage has traversed 'row' rows.  By default, stepSize is equal to one, so it will default
to integer coordinates.

Example stage motion for stageXY(2,4):

X   ->     X    ->   X   ->     X
                                |
X   <-     X    <-   X   <-     X

Returns an iterator with sequence [[0,0], [0,1], [0,2], [0,3], [1,3], [1,2], [1,1], [1,0]]

"""

def stageIter(row, col, stepSize=1):
  ri, ci = [0,0]
  stageXY = []
  stageXY.append([ri, ci])

  while ri < row:
    if ri%2 == 0:  #we are traveling right
      if ci == (col-1): # we are at the end of the range, so we should move down      
        ri = ri + 1 
      else:
        ci = ci + 1
    else:  #we are traveling left
      if ci == 0: # we are at the end of the range, so we should move down      
        ri = ri + 1 
      else:
        ci = ci - 1
    stageXY.append([ri, ci])
  stageIter = iter(stageXY)
  return iter(stageXY)

"""
Parses positive and negative trigger signals to reconstruct the motion of the stage over time.
Returns a parallel array specificying the position at the time of the triggers.
For a smoother representation, try scipy.interpolate.inter1d.....

"""


def parse1dMotion(triggers, trigStep):
  time = []
  pos = []

#  first detect the positive and negative triggers
  motion = parseStageTriggers(triggers)  #returns a time :: step direction dictionary
# combine trigger times into time
  time.append(0)
  pos.append(0)

# iterate through key value pairs, reconstructing the path of the stage.
  accum = 0
  for t in sorted(motion):
    time.append(float(t))
    accum += motion[t] * trigStep
    pos.append(accum)
  return time,pos

"""
The stage initially moves right, then traces a return path left.  The bidirectional scan may be repeated
at different velocities in the same trial.
Ex:

epoch   transit times            direction      velocity

1      [0, 620000]          'right'        3 mm/s
1      [620000, 1250000]    'left'         3 mm/s 

All of these values above can be computed from the transit intervals.
TODO:  Assumes the stage starts near pos = 0, moves negative, and then returns.  Should be generalized.
"""

def findMotionEpochs(time, pos, mode='exact'):
  assert mode in ('exact', 'robust')

  maxLvl = max(pos)  
  minLvl = min(pos)

  if mode == 'robust':
    meanP = np.mean(pos)
    maxLvl -= meanP * .001
    minLvl += meanP * .001

  
  maxInt = findLevels(pos, maxLvl, mode='both', boxWidth=2, rangeSubset=None)
  minInt = findLevels(pos, minLvl, mode='both', boxWidth=2, rangeSubset=None)
  epochs = [minInt, maxInt]
  return epochs

"""
Rather specific function for detecting positive direction and negative direction triggers.

Positive direction triggers:  from 0V to 5V for 3 samples   

Negative direction triggers:  from 5V to 0V for 3 samples

"""

def parseStageTriggers(triggers):
  pthresh = 8
  nthresh = -8
  motion = {};
  dTdt = np.diff(triggers)
  pts = np.arange(len(triggers) - 3)
  for pt in pts:
    diff = dTdt[pt] - dTdt[pt + 2]
    if diff > pthresh :
      motion[pt] = 1
    elif diff < nthresh:
      motion[pt] = -1
  return motion

"""
Recover a 3d surface from indenter lengths and stage positions.


"""

def recover3d(lengths, positions, times):



  return


