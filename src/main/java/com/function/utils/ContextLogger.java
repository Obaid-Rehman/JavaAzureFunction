package com.function.utils;

import java.util.logging.Level;

import org.apache.maven.shared.invoker.InvokerLogger;

import com.microsoft.azure.functions.ExecutionContext;

public class ContextLogger implements InvokerLogger{

        public static final int DEBUG = 4;
        public static final int ERROR = 1;
        public static final int FATAL = 0;
        public static final int INFO  = 3;
        public static final int WARN  = 2;

        private ExecutionContext _Context;
        private int _Threshold = FATAL;

        public ContextLogger(ExecutionContext context) {
         _Context = context;
        }

        @Override
        public void debug(String arg0) {
            _Context.getLogger().log(Level.FINEST, arg0);
        }

        @Override
        public void debug(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.FINEST, arg0, arg1);
        }

        @Override
        public void error(String arg0) {
            _Context.getLogger().log(Level.WARNING, arg0);
        }

        @Override
        public void error(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.WARNING, arg0, arg1);
        }

        @Override
        public void fatalError(String arg0) {
            _Context.getLogger().log(Level.SEVERE, arg0);
        }

        @Override
        public void fatalError(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.SEVERE, arg0, arg1);
        }

        @Override
        public int getThreshold() {
            return _Threshold;
        }

        @Override
        public void info(String arg0) {
            _Context.getLogger().log(Level.INFO, arg0);
        }

        @Override
        public void info(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.INFO, arg0, arg1);
        }

        @Override
        public boolean isDebugEnabled() {
            return _Context.getLogger().isLoggable(Level.FINEST);
        }

        @Override
        public boolean isErrorEnabled() {
            return _Context.getLogger().isLoggable(Level.WARNING);
        }

        @Override
        public boolean isFatalErrorEnabled() {
            return _Context.getLogger().isLoggable(Level.SEVERE);
        }

        @Override
        public boolean isInfoEnabled() {
            return _Context.getLogger().isLoggable(Level.INFO);
        }

        @Override
        public boolean isWarnEnabled() {
            return _Context.getLogger().isLoggable(Level.WARNING);
        }

        @Override
        public void setThreshold(int arg0) {
            if (arg0 == DEBUG ||
                arg0 == FATAL ||
                arg0 == INFO ||
                arg0 == ERROR ||
                arg0 == WARN) {
                    _Threshold = arg0;
                } else {
                    return;
                }
        }

        @Override
        public void warn(String arg0) {
            _Context.getLogger().log(Level.WARNING, arg0);
        }

        @Override
        public void warn(String arg0, Throwable arg1) {
            _Context.getLogger().log(Level.WARNING, arg0, arg1);
        }
 
}
