const express = require('express');
const cors = require('cors');
const neo4j = require('neo4j-driver');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Neo4j Driver Initialization
const driver = neo4j.driver(
  'bolt://localhost:7687',
  neo4j.auth.basic('neo4j', '22510012') 
);

// Test database connection
const session = driver.session();
session.run('RETURN 1')
  .then(() => {
    console.log('✅ Connected to Neo4j database successfully');
    session.close();
  })
  .catch(error => {
    console.error('❌ Failed to connect to Neo4j database:', error);
    session.close();
  });

// API Endpoint to Check Citation
app.get('/api/check-citation', async (req, res) => {
  const { paperA, paperB } = req.query;

  const session = driver.session();

  try {
    const result = await session.run(
      `
      MATCH (a:Paper {id: $paperA}), (b:Paper {id: $paperB})
      RETURN EXISTS((a)-[:CITES*1..]->(b)) AS citationExists
      `,
      { paperA, paperB }
    );

    const citationExists = result.records[0].get('citationExists');
    res.json({ citationExists });
  } catch (error) {
    console.error('Error checking citation:', error);
    res.status(500).json({ error: 'An error occurred while checking citation.' });
  } finally {
    await session.close();
  }
});

// Start the Server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
