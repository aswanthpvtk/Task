
const inventoryReordering  = [
    { item_id: 1, current_stock: 40, forecasted_demand: 80, reorder_cost_per_unit: 10, batch_size: 20 },
    { item_id: 2, current_stock: 50, forecasted_demand: 120, reorder_cost_per_unit: 15, batch_size: 30 },
    { item_id: 3, current_stock: 70, forecasted_demand: 80, reorder_cost_per_unit: 12, batch_size: 50 },
    { item_id: 4, current_stock: 80, forecasted_demand: 80, reorder_cost_per_unit: 8, batch_size: 10 },
  ];
  
  
  function generateReorderPlan(inventoryReordering ) {
    const reorderPlan = [];
  
    inventoryReordering .forEach(item => {
      const shortage = item.forecasted_demand - item.current_stock;
      if (shortage > 0) {
        
        const orderQuantity = Math.ceil(shortage / item.batch_size) * item.batch_size;
        reorderPlan.push({ item_id: item.item_id, units_to_order: orderQuantity });
      } else {
        reorderPlan.push({ item_id: item.item_id, units_to_order: 0 });
      }
    });
  
    return reorderPlan;
  }
 
  const reorderPlan = generateReorderPlan(inventoryReordering );
  console.log("Reorder Plan:");
  reorderPlan.forEach(plan => {
    console.log(`Item ID: ${plan.item_id}, Units to Order: ${plan.units_to_order}`);
  });