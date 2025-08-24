package com.healthdiary.util;

import java.util.logging.Logger;
import java.util.logging.Level;

public class LogUtil {
    private static final Logger logger = Logger.getLogger(LogUtil.class.getName());
    
    public static void logError(String className, String methodName, String message, Exception e) {
        logger.log(Level.SEVERE, String.format("[%s.%s] %s", className, methodName, message), e);
    }
    
    public static void logError(String className, String methodName, Exception e) {
        logger.log(Level.SEVERE, String.format("[%s.%s] Database operation failed", className, methodName), e);
    }
    
    public static void logInfo(String className, String methodName, String message) {
        logger.log(Level.INFO, String.format("[%s.%s] %s", className, methodName, message));
    }
    
    public static void logWarning(String className, String methodName, String message) {
        logger.log(Level.WARNING, String.format("[%s.%s] %s", className, methodName, message));
    }
}