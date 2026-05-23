const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electronAPI', {
  // Connection
  getConn:    ()     => ipcRenderer.invoke('get-conn'),
  setConn:    (conn) => ipcRenderer.invoke('set-conn', conn),
  clearConn:  ()     => ipcRenderer.invoke('clear-conn'),
  // File save
  saveFile:   (opts) => ipcRenderer.invoke('save-file', opts),
  // Platform
  platform: process.platform
});
