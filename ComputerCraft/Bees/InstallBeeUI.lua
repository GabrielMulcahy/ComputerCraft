print("Installing BuzzCorp BeeBank Client")
textutils.slowPrint("********")

if not fs.exists("cobalt-lib") then
    shell.run("pastebin", "run", "h5h4fm3t")
end


shell.run("rm", "Common")
shell.run("rm", "Client")

shell.run("pastebin", "get", "zBeH1B94", "Common/Globals")
shell.run("pastebin", "get", "nUN5y4Q3", "Common/BooshCommonLua")
shell.run("pastebin", "get", "VnHxhmmD", "Client/BeeDBClient")