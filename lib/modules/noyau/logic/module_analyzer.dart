
/// Base interface for all module analyzers.
abstract class ModuleAnalyzer<I, O> {
  const ModuleAnalyzer();

  Future<O> analyze(I input);
}

