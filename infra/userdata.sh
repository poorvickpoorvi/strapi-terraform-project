
apt-get update -y
apt-get upgrade -y
apt-get install -y curl git

# Install Node.js (v20.x)
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs build-essential

# Install pm2 globally to keep app running
npm install -g pm2

# Clone your Strapi project
cd /opt
git clone https://github.com/poorvickpoorvi/strapi-terraform-project.git

# Go into the Strapi app folder
cd /opt/strapi-terraform-project/strapi-app

# Install dependencies, build, and start in production
npm install
npm run build

# Start Strapi via pm2 so it survives restarts
pm2 start "npm run start" --name strapi
pm2 startup systemd -u root --hp /root
pm2 save
