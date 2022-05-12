docker_image(
    name="cloudbox", dependencies=[":entrypoint"], image_tags=["{build_args.GIT_TAG}"]
)

file(
    name="entrypoint",
    source="docker-entrypoint.sh",
)
