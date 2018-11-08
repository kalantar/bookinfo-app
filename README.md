# bookinfo-app

# Istio Multimesh on IBM Multicloud Manager

Contains two example descriptions of the Istio bookinfo sample application as MCM `Applications`. 
The first, [as_one_application](as_one_application) defines bookinfo as a single `Application`. 
The second [as_three_applications](as_three_applications) breaks bookinfo into three `Applications` on the theory that each microservice is developed _and managed_ independently.

## Requirements
Two or more ICP clusters, one hosting MCM hub and at least 2 managed clusters. Set up istio multimesh as per instructions [here](https://github.com/istio-ecosystem/wharf-multicluster-sync/tree/master/docs/install).

Define environment variables
1. `MCM_HUB` - kubernetes context for MCM hub cluster
2. `CLUSTER1` - kubernetes context for first managed cluster
3. `CLUSTER2` - kubernetes context for second managed cluster

Define demo tools:

    source demo.helpers

## _One Application Version_
Deploy bookinfo and configure the istio ingress gateway to enable external access:

    helm --kube-context $CLUSTER1 install -n bookinfo as_one_application/src/bookinfo --tls 
    helm --kube-context $CLUSTER1 install -n bookinfo-gateway src/expose-productpage --tls

Verify access via curl or a browser:

    curl $(demo_url)

## _Three Application Version_
Deploy bookinfo and configure the istio ingress gateway to enable external access:

    as_three_applications/deploy.sh $CLUSTER1 
    helm --kube-context $CLUSTER1 install -n bookinfo-gateway src/expose-productpage --tls

Verify access via curl or a browser:

    curl $(demo_url)

## Running demo scenarios
### Scenario 1: Move _ratings_ from $CLUSTER1 to $CLUSTER2

    # move ratings service by patching placement policy
    demo_move ratings $CLUSTER2
    demo_show_placement

    # expose ratings (on $CLUSTER2) to reviews (on $CLUSTER1)
    demo_expose ratings $CLUSTER2

### Scenario 2: Also move _reviews_ from $CLUSTER1 to $CLUSTER2

    # stop exposing ratings
    demo_hide ratings $CLUSTER2

    # move reviews service by patching placement policy
    demo_move reviews $CLUSTER2

    # expose reviews (on $CLUSTER2) to productpage ($CLUSTER1)
    demo_expose reviews $CLUSTER2

### Scenario 3: Move _reviews_ and _rating_ back to $CLUSTER1

    # stop exposing reviews
    demo_hide reviews $CLUSTER2

    # move reviews and ratings services by patching placement policies
    demo_move reviews $CLUSTER1
    demo_move ratings $CLUSTER1

### Scenario 4: Move productpage from $CLUSTER1 to $CLUSTER2

    # move productpage service by patching placement policy
    demo_move productpage $CLUSTER2

    # expose productpage (on $CLUTER2) to gateway (on $CLUSTER1)
    demo_expose productpage $CLUSTER2

    # expose details (on $CLUSTER1) to productpage (on $CLUSTER2)
    demo_expose details $CLUSTER1

    # expose reviews (on $CLUSTER1) to productpage (on $CLUSTER2)
    demo_expose reviews $CLUSTER1

### Scenario 5: Move productpage back to $CLUSTER1

    # stop exposing reviews, details and productpage
    demo_hide details $CLUSTER1
    demo_hide reviews $CLUSTER1
    demo_hide productpage $CLUSTER2

    # move productpage service by patching placement policy
    demo_move productpage $CLUSTER1