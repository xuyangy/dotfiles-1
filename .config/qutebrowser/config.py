config.load_autoconfig()
config.bind('<Ctrl-a>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-Shift-a>', 'fake-key <Ctrl-a>', mode='insert') # select all
