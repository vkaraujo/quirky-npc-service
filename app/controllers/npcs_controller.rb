class NpcsController < ApplicationController
  def index
    filtered = Npc.all
    filtered = filtered.by_species(params[:species])
    filtered = filtered.by_alignment(params[:alignment])
    filtered = filtered.by_mood(params[:mood]) if params[:mood]
    filtered = filtered.by_job(params[:job]) if params[:job]
    filtered = filtered.by_quirk(params[:quirk]) if params[:quirk]

    @pagy, @npcs = pagy(filtered)
    render json: {
      npcs: ActiveModelSerializers::SerializableResource.new(@npcs),
      pagination: {
        page: @pagy.page,
        items: @pagy.items,
        pages: @pagy.pages,
        count: @pagy.count
      }
    }
  end

  def show
    @npc = Npc.find(params[:id])
    render json: @npc
  end

  def random
    @npc = Npc.order("RANDOM()").first
    render json: @npc
  end

  def generate
    npc_data = NpcGeneratorService.generate
    npc = Npc.new(npc_data)

    if npc.save
      render json: npc, status: :ok
    else
      Rails.logger.error("Failed to generate NPC: #{npc.errors.full_messages}")
      render json: {
        error: 'Unprocessable Entity',
        message: npc.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def create
    npc = Npc.new(npc_params)

    if npc.save
      render json: npc, status: :created
    else
      render json: {
        error: 'Unprocessable Entity',
        message: npc.errors.full_messages.to_sentence
      }, status: :unprocessable_entity
    end
  end

  def update
    @npc = Npc.find(params[:id])

    if @npc.update(npc_params)
      render json: @npc
    else
      render json: { errors: @npc.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @npc = Npc.find(params[:id])
    @npc.destroy

    head :no_content
  end

  private

  def npc_params
    params.require(:npc).permit(:name, :job, :quirk, :mood, :species, :alignment)
  end
end
