// Decompile functions at the given addresses (args: addr[=name] ...) into stdout.
import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.*;
import ghidra.program.model.address.*;
import ghidra.program.model.listing.*;
import ghidra.app.cmd.disassemble.DisassembleCommand;
import ghidra.app.cmd.function.CreateFunctionCmd;
public class Decomp extends GhidraScript {
  public void run() throws Exception {
    DecompInterface di = new DecompInterface(); di.openProgram(currentProgram);
    for (String a : getScriptArgs()) {
      String[] p = a.split("=");
      Address ad = toAddr(p[0]);
      new DisassembleCommand(ad, null, true).applyTo(currentProgram, monitor);
      Function f = getFunctionAt(ad);
      if (f == null) { new CreateFunctionCmd(ad).applyTo(currentProgram, monitor); f = getFunctionAt(ad); }
      if (f == null) { println("NOFUNC " + a); continue; }
      if (p.length > 1) f.setName(p[1], ghidra.program.model.symbol.SourceType.USER_DEFINED);
      DecompileResults r = di.decompileFunction(f, 120, monitor);
      println("=== " + a + "\n" + (r.decompileCompleted() ? r.getDecompiledFunction().getC() : r.getErrorMessage()));
    }
  }
}
