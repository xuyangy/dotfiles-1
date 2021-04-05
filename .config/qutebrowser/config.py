config.load_autoconfig()
config.bind('<Ctrl-a>', 'fake-key <Home>', mode='insert')
config.bind('<Ctrl-Shift-a>', 'fake-key <Ctrl-a>', mode='insert') # select all

config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.bg", "black")
