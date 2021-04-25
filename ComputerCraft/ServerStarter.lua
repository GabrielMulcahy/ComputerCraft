print("Updating BuzzCorp Server")
textutils.slowPrint("||||||||||||||||||||||||||||||||")

shell.run("rm", "Common")
shell.run("rm", "Bees")
shell.run("rm", "Bank")
shell.run("rm", "Security")

shell.run("pastebin", "get", "zBeH1B94", "Common/Globals")
shell.run("pastebin", "get", "nUN5y4Q3", "Common/BooshCommonLua")

shell.run("pastebin", "get", "gMXmVmmR", "Bees/BeeDBConnector")
shell.run("pastebin", "get", "aFH1nDQu", "Bees/BeeDBServer")

shell.run("pastebin", "get", "FDytw0XE", "Security/DoorDBConnector")
shell.run("pastebin", "get", "iTENRHKw", "Security/FloppyDBConnector")
shell.run("pastebin", "get", "uLT7khSK", "Security/SecurityServer")

shell.run("bg", "Bees/BeeDBServer", "top")
shell.run("bg", "Security/SecurityServer", "top")