# bookinfo-app

## Issues

How does one define _ratings_ as an `Application`? 
One could define 2 helm charts, one with `Application`, `Deployable` and `PlacementPolicy`; the other with the `Service` and `Deployment`. 
However, how do we do it with a single chart? The PlacementPolicy does not seem to have any effect.