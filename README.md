# java-run-script
The purpose of this project is to provide a way to run Java applications that is as simple and as efficient as possible. 

THE PROBLEM

One of the biggest problems with Java programs for end users is that Java programs are very hard to start. They typically require a lot of complex command line parameters that even their developers can't remember. The runnable jar format is helpful, but it is still too much work if you're running it from the command line. Compare, for example, the invocation of the Windows "dir" program with a Java program that would do the same thing:

Native "dir" command to list files in the current directory:
<pre>
C:\My Data Files>dir
</pre>

Java equivalent of "dir" to list files in the current directory:
<pre>
C:\My Data Files>java -jar "C:\Program Files\My Company Name\File Lister Program\dir.jar"
</pre>

The above illustrates the problems:
1. It requires the user to type 2 more parameters.
2. One of the parameters has to be the path to the jar file because your not going to copy that jar file to every directory that you want to run the program from. This is assuming that it operates on some data file or directory. You're going to change to the directory where your data file is and then invoke your Java program. This requires you to type the path to your jar file because it is not in the same directory as your data file. There is no such thing as a JARPATH that Java looks at to find jar files. Maybe there should be, but that is a problem for another day.

The user should only be required to perform the fewest possible number of steps, and to remember the fewest possible number of file names and folder names. In particular, it should work in exactly the same way, from the user's perspective, as running native program like "ls" on Linux or "dir" on Windows. It is wrong to expect users to have to remember a special procedure for running your program just because you chose to write it in Java. Users don't care what language you used to write the program and they shouldn't have to care. They just want to use the program (hopefully). Any special procedure, no matter now small, is a barrier to a user, and a barrier to the acceptance of your program.

NON-SOLUTIONS

You can solve this problem by using an installer process like IzPack along with a batch file to invoke your Java jar file. The IzPack install can add the directory containing your batch file to the system PATH. This is a good solution for a large program with lots setup requirements and lots of components that need to be put into particular locations. But, it is really overkill and a lot of unnecessary work for a small utility program. You're going to put more work into the installer process than the program itself.

The IzPack solution also requires the user to do extra work before they can run your program. That is, they have to run the installer program and click next through all the panels in your installer. For small utility programs, that is a waste of the user's time. Small utility programs should be ready to run as soon as they're downloaded. Efficiency is important to your users. If it requires a lot of steps, that in their experience might very well fail, they're going to look elsewhere. The more steps you put in the user's way, the more opportunity for failure they're going to imagine when performing all those steps. If you require an IzPack installation, there's a possibility that the installation itself might fail and user will never be able to even try to run your program. Users, consciously or unconsciously, factor these issues into their decision on whether to download and try out one program versus another to see if it solves their problem. I know I do. Users don't want to waste a bunch of time going through all the steps you put in their way only to find out that the end result doesn't work for them.

You can use a wrapper program, like Launch4j or JSmooth, that wraps your jar file in a Windows exe. This could be a good solution too. But it is extra work and you will end up with an exe that is no longer cross-platform. Java is supposed to be cross-platform. Normally you distribute your jar with a batch file and a UNIX shell script to start it up. That covers most of the platforms in the world. But, if you distribute an exe file, you have defeated the purpose of using Java in the first place. You can't then copy that same file to a non-Windows machine and run it. If you retain the jar file, you can still run that on any platform.

DISCLAIMER

I'm not saying you should never use IzPack, Launch4j or JSmooth. There are surely cases where those are the right solutions. What I'm saying is that for small utility programs that have no other requirements that might necessitate an IzPack, Launch4j or JSmooth solution, the solution I'm proposing is preferable. For example, JSmooth might make sense if you're already using some native Windows APIs through JNI that ties you to Windows anyway. Since you're already tied to Windows there's no reason to try to deploy a platform-independent jar file. You could still do it, but it just isn't necessary in that case. In my opinion this is a valid case for a Java programmer, building a solution that requires access to native APIs. You don't want to switch languages just because you're required to access a native API like the Windows Scheduler. So, you use Java to build a platform-specific program. Definitely, you want to avoid platform-specific programs. But sometimes you must do it. So, do it with Java. If you use C++ or C# instead, it's going to be platform-specific anyway. So you might as well use Java and build a platform-specific program, if you're already a Java programmer.

SOLUTION

(Yet to be written. Read the code for now.)


