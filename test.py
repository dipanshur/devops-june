import json
import random
from datetime import datetime, timedelta
from typing import List, Dict, Tuple

# A comprehensive data analysis and visualization system

class DataAnalyzer:
    """Analyzes and processes data with various statistical methods."""
    
    def __init__(self, data: List[float]):
        self.data = data
        self.timestamp = datetime.now()
    
    def calculate_mean(self) -> float:
        """Calculate the mean of the dataset."""
        return sum(self.data) / len(self.data) if self.data else 0
    
    def calculate_median(self) -> float:
        """Calculate the median of the dataset."""
        sorted_data = sorted(self.data)
        n = len(sorted_data)
        if n % 2 == 0:
            return (sorted_data[n//2 - 1] + sorted_data[n//2]) / 2
        return sorted_data[n//2]
    
    def calculate_standard_deviation(self) -> float:
        """Calculate standard deviation."""
        mean = self.calculate_mean()
        variance = sum((x - mean) ** 2 for x in self.data) / len(self.data)
        return variance ** 0.5
    
    def find_outliers(self, threshold: float = 2.0) -> List[float]:
        """Identify outliers using standard deviation."""
        mean = self.calculate_mean()
        std_dev = self.calculate_standard_deviation()
        return [x for x in self.data if abs(x - mean) > threshold * std_dev]

class ReportGenerator:
    """Generates formatted reports from analysis results."""
    
    def __init__(self, analyzer: DataAnalyzer):
        self.analyzer = analyzer
    
    def generate_summary(self) -> Dict:
        """Generate a summary report."""
        return {
            "timestamp": self.analyzer.timestamp.isoformat(),
            "data_count": len(self.analyzer.data),
            "mean": round(self.analyzer.calculate_mean(), 2),
            "median": round(self.analyzer.calculate_median(), 2),
            "std_dev": round(self.analyzer.calculate_standard_deviation(), 2),
            "min": min(self.analyzer.data),
            "max": max(self.analyzer.data),
            "outliers": self.analyzer.find_outliers()
        }
    
    def export_json(self, filename: str):
        """Export report to JSON file."""
        with open(filename, 'w') as f:
            json.dump(self.generate_summary(), f, indent=2)

def main():
    """Main execution function."""
    # Generate sample data
    sample_data = [random.gauss(100, 15) for _ in range(100)]
    
    # Analyze data
    analyzer = DataAnalyzer(sample_data)
    report = ReportGenerator(analyzer)
    
    # Display results
    summary = report.generate_summary()
    print("Data Analysis Report")
    print("=" * 40)
    for key, value in summary.items():
        print(f"{key}: {value}")
    
    # Export results
    report.export_json("analysis_report.json")
    print("\nReport exported to analysis_report.json")

if __name__ == "__main__":
    main()