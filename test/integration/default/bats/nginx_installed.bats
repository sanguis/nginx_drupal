#!/usr/bin/env bats

@test "nginx is running" {
	run which nginx
	#run service nginx status

		[ "$status" -eq 0 ]
#		[ "$output" = "* nginx is not running" ]
}
