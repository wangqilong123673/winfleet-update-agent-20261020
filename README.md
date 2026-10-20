# WinFleet 更新 Agent 恢复包（2026-10-20）

中控二进制：`winfleet-server.exe`（含「更新 Agent」API + 今晚离线假告警修复：offline floor + resolved_no_gap）

## 下载用法

1. 把 **所有** `part_00.b64` … `part_14.b64` 和 `assemble.ps1` 下到同一文件夹
2. 在该文件夹打开 PowerShell，运行：

```powershell
powershell -ExecutionPolicy Bypass -File .\\assemble.ps1
```

3. 得到 `winfleet-server.exe` 后拷到 `D:\\jiankong\\bin\\`：
   - `winfleet-server-20261020upd.exe`（版本化）
   - `winfleet-server.exe.new`（下次启动用）
4. Web：把 `web\\index.html` 与 `web\\assets\\design.js` 覆盖到 `D:\\jiankong\\web\\`（缓存 `?v=20261020upd1`）
5. **双击** `D:\\jiankong\\一键启动.cmd` 重启中控（不要任务管理器强杀）

## 校验

- exe MD5：`9873F7EC552E0789CF96EF61D852F5BA`
- 大小：22698496 字节
- gz MD5：`FB185FAD4FA8BB68EA1F0A72779AF7C3`
- 分片：15 个 `part_*.b64`
