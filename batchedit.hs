import System.Process
import System.IO
import System.Environment
import Directory

-- Returns the contents of the working directory as a newline-delimited string
listDirectory :: IO [String]
listDirectory = do 
  input <- readProcess "ls" [] []
  return (lines input)

launchFile :: String -> String -> IO ProcessHandle
launchFile prog name = do
  runProcess (prog) [name] Nothing Nothing Nothing Nothing Nothing

edit :: String -> String -> IO Char
edit prog file = do 
  launchFile prog file
  putStrLn "Press enter to continue, ctrl+C to quit"
  getChar

main :: IO ()
main = do
  args <- getArgs
  let
    prog = if ((length args) > 0)
      then head args
      else "gimp"
  files <- listDirectory
  mapM_ (edit prog) files
