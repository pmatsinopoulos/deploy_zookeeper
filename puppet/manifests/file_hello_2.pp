file { '/tmp/hello2.txt':
  ensure => file,
  content => "hello\n",
}
