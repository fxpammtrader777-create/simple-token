# All Mumbai Testnet RPC Options

## 🔄 Multiple RPC Endpoints to Try

If one doesn't work, try the next one:

---

## 📋 RPC URLs (Try in Order)

### Option 1: Alchemy (Demo) - Currently Set
```env
MUMBAI_RPC_URL=https://polygon-mumbai.g.alchemy.com/v2/demo
```
**Status**: ✅ Just updated to this

---

### Option 2: PublicNode
```env
MUMBAI_RPC_URL=https://polygon-mumbai-bor.publicnode.com
```

---

### Option 3: Ankr
```env
MUMBAI_RPC_URL=https://rpc.ankr.com/polygon_mumbai
```

---

### Option 4: QuickNode
```env
MUMBAI_RPC_URL=https://rpc.ankr.com/polygon_mumbai
```

---

### Option 5: Chainstack
```env
MUMBAI_RPC_URL=https://matic-mumbai.chainstacklabs.com
```

---

### Option 6: GetBlock
```env
MUMBAI_RPC_URL=https://matic.getblock.io/YOUR_API_KEY/testnet
```
(Requires free API key from getblock.io)

---

## 🔧 How to Change RPC URL

**Edit `.env` file**:
1. Open `.env`
2. Find `MUMBAI_RPC_URL=...`
3. Replace with one of the URLs above
4. Save
5. Try deploying again

---

## 💡 Alternative: Use Your Own RPC

### Get Free RPC from Alchemy:
1. Go to: https://www.alchemy.com/
2. Create free account
3. Create new app
4. Select "Polygon" → "Mumbai"
5. Copy your RPC URL
6. Use in `.env`:
   ```
   MUMBAI_RPC_URL=https://polygon-mumbai.g.alchemy.com/v2/YOUR_API_KEY
   ```

### Get Free RPC from Infura:
1. Go to: https://www.infura.io/
2. Create free account
3. Create new project
4. Select "Polygon Mumbai"
5. Copy your RPC URL
6. Use in `.env`:
   ```
   MUMBAI_RPC_URL=https://polygon-mumbai.infura.io/v3/YOUR_API_KEY
   ```

---

## 🎯 Current Status

**Just updated to**: Alchemy Demo RPC

**Try deploying**:
```bash
npm run deploy:testnet
```

---

## ⚠️ If All RPCs Timeout

**Possible issues**:
1. **Internet connection** - Check your connection
2. **Firewall** - May be blocking RPC connections
3. **VPN** - Try disabling VPN
4. **Corporate network** - May block RPC endpoints

**Solutions**:
- Try different network (home vs mobile hotspot)
- Disable VPN
- Check firewall settings
- Try from different location

---

## 🔄 Quick RPC Switcher

**To quickly try different RPCs**, edit `.env`:

**Current** (Alchemy Demo):
```env
MUMBAI_RPC_URL=https://polygon-mumbai.g.alchemy.com/v2/demo
```

**Try PublicNode**:
```env
MUMBAI_RPC_URL=https://polygon-mumbai-bor.publicnode.com
```

**Try Ankr**:
```env
MUMBAI_RPC_URL=https://rpc.ankr.com/polygon_mumbai
```

---

**I've updated to Alchemy Demo RPC. Try deploying again!**
