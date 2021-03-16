package site.ycsb.db;

/**
 * Stats class.
 */
public final class Stats {
  /**
   * Holder class.
   */
  public static final class Holder {
    private static Stats instance = new Stats();

    private Holder() {
    }
  }


  private int totalClients = 0;
  private int finishedClients = 0;
  private int totalTransactions = 0;
  private int totalCommits = 0;
  private int totalAborts = 0;

  private Stats() {
  }

  public static Stats getInstance() {
    return Holder.instance;
  }

  public synchronized void newClient() {
    this.totalClients++;
  }

  public synchronized void clientFinished(int clientTotalTransactions, int clientCommits, int clientAborts) {
    this.totalTransactions += clientTotalTransactions;
    this.totalCommits += clientCommits;
    this.totalAborts += clientAborts;
    this.finishedClients++;
    if (this.totalClients == this.finishedClients) {

      System.out.printf("\nEnded JDBC benchmark.\nNumber of clients: %d\nTotal transactions: %d\n" +
          "Committed: %d (%f)\nAborted: %d (%f)\n",
          this.totalClients, this.totalTransactions,
          this.totalCommits, this.totalCommits / (float) this.totalTransactions * 100,
          this.totalAborts, this.totalAborts / (float) this.totalTransactions * 100);
    }
  }
}
