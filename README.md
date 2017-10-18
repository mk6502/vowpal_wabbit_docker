# wovpal_wabbit_docker

Vowpal Wabbit in a Docker container.

# Example #

Run Vowpal Wabbit with:

    docker run --rm --volume=$(pwd):/data -t mikestaszel/vw:8.3.0 /data/click.train.vw -f /data/click.model.vw --loss_function logistic --link logistic --passes 1 --cache_file /data/click.cache.vw
