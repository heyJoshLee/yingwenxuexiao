class Admin::UnitsController < AdminController

  before_action :set_unit, only: [:show, :update, :edit, :destroy]
  before_action :set_course, only: [:create, :destroy]
  
  def new
    @unit = Unit.new
  end

  def create
    @unit = Unit.new(unit_params)
    @unit.course_id = @course.id
    @unit.position = @course.units.length + 1

    if @unit.save
      flash[:success] = "Unit was saved"
      redirect_to rearrange_admin_course_path(@course)
    else
      flash.now[:danger] = "There was a problem and the unit was not saved"
      redirect_to rearrange_admin_course_path(@course)
    end
  end


  def destroy
    @unit.destroy
    flash[:success] = "Unit was deleted."
    redirect_to rearrange_admin_course_path(@course)
  end


  def update
    if @unit.update(unit_params)
      flash[:success] = "unit was saved"
      redirect_to rearrange_admin_course_path(@unit.course)
    else
      flash.now[:danger] = "There was a problem and the unit was not saved"
      render :edit
    end
  end

  private

  def set_course
    @course = Course.find_by(slug: params[:course_id])
  end

  def set_unit
    @unit = Unit.find_by(slug: params[:id])
  end

  def unit_params
    params.require(:unit).permit!
  end

end