# Vowpal Wabbit Docker Image #

Vowpal Wabbit as a Docker image.

# Example #

Run Vowpal Wabbit with:

    docker run --rm --volume=$(pwd):/data -t mikestaszel/vw /data/click.train.vw -f /data/click.model.vw --loss_function logistic --link logistic --passes 1 --cache_file /data/click.cache.vw
