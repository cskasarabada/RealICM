const { app, BrowserWindow, Menu, shell, ipcMain, dialog } = require('electron');
const path = require('path');
const fs   = require('fs');

// ── Shared Oracle connection state (all windows share this) ──────────────
let oracleConn = { url:'', user:'', pass:'', apiKey:'' };

let mainWin = null;

function createMainWindow() {
  mainWin = new BrowserWindow({
    width: 1440, height: 900, minWidth: 1100, minHeight: 700,
    titleBarStyle: process.platform === 'darwin' ? 'hiddenInset' : 'default',
    title: 'RealICM',
    icon: path.join(__dirname, 'assets', process.platform === 'win32' ? 'icon.ico' : 'icon.png'),
    webPreferences: {
      nodeIntegration: false,
      contextIsolation: true,
      preload: path.join(__dirname, 'preload.js'),
      webSecurity: false
    },
    backgroundColor: '#0D0618',
    show: false
  });
  mainWin.loadFile(path.join(__dirname, 'renderer', 'index.html'));
  mainWin.once('ready-to-show', () => mainWin.show());
  mainWin.on('closed', () => { mainWin = null; });
}

// ── IPC: connection management ───────────────────────────────────────────
ipcMain.handle('get-conn',  () => oracleConn);
ipcMain.handle('set-conn',  (_, conn) => { oracleConn = { ...oracleConn, ...conn }; return true; });
ipcMain.handle('clear-conn',() => { oracleConn = { url:'', user:'', pass:'', apiKey:'' }; return true; });

// ── IPC: file save ───────────────────────────────────────────────────────
ipcMain.handle('save-file', async (_, { filename, data, type }) => {
  const filters =
    type === 'excel' ? [{ name:'Excel', extensions:['xlsx'] }] :
    type === 'csv'   ? [{ name:'CSV',   extensions:['csv']  }] :
    type === 'pdf'   ? [{ name:'PDF',   extensions:['pdf']  }] :
                       [{ name:'JSON',  extensions:['json'] }];
  const result = await dialog.showSaveDialog(mainWin, {
    defaultPath: path.join(app.getPath('downloads'), filename), filters
  });
  if (!result.canceled) {
    fs.writeFileSync(result.filePath, Buffer.from(data));
    return { success: true, path: result.filePath };
  }
  return { success: false };
});

// ── Menu ─────────────────────────────────────────────────────────────────
function buildMenu() {
  const T = [
    ...(process.platform === 'darwin' ? [{
      label: 'RealICM',
      submenu: [{ role:'about' }, { type:'separator' }, { role:'quit' }]
    }] : []),
    { label: 'View', submenu: [
      { role:'reload' }, { role:'forceReload' },
      { type:'separator' },
      { role:'resetZoom' }, { role:'zoomIn' }, { role:'zoomOut' },
      { type:'separator' }, { role:'togglefullscreen' },
      { type:'separator' },
      { label:'Dev Tools', accelerator:'Alt+CmdOrCtrl+I',
        click: () => mainWin?.webContents.toggleDevTools() }
    ]},
    { label: 'Help', submenu: [
      { label:'Oracle ICM Docs',
        click: () => shell.openExternal('https://docs.oracle.com/en/cloud/saas/incentive-compensation/') },
      { label:'GitHub',
        click: () => shell.openExternal('https://github.com/cskasarabada/RealICM') }
    ]}
  ];
  Menu.setApplicationMenu(Menu.buildFromTemplate(T));
}

app.whenReady().then(() => {
  createMainWindow();
  buildMenu();
  app.on('activate', () => { if (!mainWin) createMainWindow(); });
});
app.on('window-all-closed', () => { if (process.platform !== 'darwin') app.quit(); });
