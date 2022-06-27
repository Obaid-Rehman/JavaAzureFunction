package com.function;

import java.io.IOException;

import org.apache.maven.shared.invoker.InvocationOutputHandler;

import com.microsoft.azure.functions.ExecutionContext;

public class ContextInvocationHandler implements InvocationOutputHandler {

        private ExecutionContext _Context;

        public ContextInvocationHandler(ExecutionContext context) {
            _Context = context;
        }
        @Override
        public void consumeLine(String arg0) throws IOException {
            if (arg0 == null) {
                _Context.getLogger().info("");
            } else {
                _Context.getLogger().info(arg0);
            }
        }
 
}
