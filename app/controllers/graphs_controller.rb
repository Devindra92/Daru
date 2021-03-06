class GraphsController < ApplicationController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]

  # GET /graphs
  # GET /graphs.json
  def index
    @graphs = Graph.all
    @df = csv_load
    @dff = @df.where(
      @df['Order Priority']
      )
    @name = Daru::Vector.new @df['Country']
    @order = Daru::Vector.new  @df.group_by('Order Priority').size
  end

  # GET /graphs/1
  # GET /graphs/1.json
  def show
    @data_frame = csv_load
    @d_frame = @data_frame.where(
      @data_frame['Sales Channel']
      .in(['Offline'])
      )
    @dff = @data_frame.where(
      @data_frame['Order Priority']
      )

  end

  # GET /graphs/new
  def new
    @graph = Graph.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  # POST /graphs.json
  def create
    @graph = Graph.new(graph_params)

    respond_to do |format|
      if @graph.save
        format.html { redirect_to @graph, notice: 'Graph was successfully created.' }
        format.json { render :show, status: :created, location: @graph }
      else
        format.html { render :new }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphs/1
  # PATCH/PUT /graphs/1.json
  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to @graph, notice: 'Graph was successfully updated.' }
        format.json { render :show, status: :ok, location: @graph }
      else
        format.html { render :edit }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphs/1
  # DELETE /graphs/1.json
  def destroy
    @graph.destroy
    respond_to do |format|
      format.html { redirect_to graphs_url, notice: 'Graph was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = Graph.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graph_params
      params.fetch(:graph, {})
    end

    def csv_load
     Daru::DataFrame.from_csv('sales.csv')
    end
end
